Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6E653A3AA
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 13:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbiFALOe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 07:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244616AbiFALOd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 07:14:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5828DA2053;
        Wed,  1 Jun 2022 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654082072; x=1685618072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w6rb1yArUXFgTeXBnoYpCKfZMoBKGxsNXhDhK0wxxm8=;
  b=bbTfO+QOkI/99bNaBfSrowxnmuqYkzqLNO3QIfmrwZDTe5g5YUB6HqLb
   QnaU3926OYffNBpaBCc7bCrho9HTblG62Pzfi3gFA1rtOD8fflwRrtl0z
   f8bXzBHVT0wMJeeI4vWAfo57uroDefW1yjUjMCrCzYNbok+U6Ea4FQNHc
   cUNqeL3WBMqqn8FuQUHjRL/r6H4OvpUEpZZqjvgmQhQki9gQZ8AXtMJ8L
   H7n+sxR/vle2atspCN0o89zo6ldKQUKv0W95RDEodyHgTXtusZC6Xqv4m
   Eu7CcaYaWvTsL/sYjy8uNuGElfVFDtJznzwQhn5vLz2drVMKuEHDcjEQZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255424425"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="255424425"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 04:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="633486096"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jun 2022 04:14:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 04:14:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 04:14:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 04:14:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bmx3fY5WoIJFyesR/CH88DnMhDJE/98n5ccUPbqjVu6SpmLhPOtlxpavAwqtsCl7H/r+NWFoAolZb9MxisuM2R892Viw+gaWGZC/uCTu0IadJtgKLCrqWYaqXO83U87YblBGpkGhRqzm73O3OtzwGsPkccXzRvuMKZxESRrcyBtJEA8rhfVHOziCqsxAmiAH5SPg2dZ51G1TfrGb09zBRplwWPb5QwtqDzQH/kTUcKRClaBSSv12C5zWmiXsfvTqAV903KsFx1ulcoBSXV5ri6DgH/rOMKipoU+aAMA69+zpWUiqUSi/2MtYbVjs7FwyPp+j72pnHKCFNggUk+BDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maQlKXck+QGosqd6rj6GvRAHERSlbS1qIVnRuenIZ9g=;
 b=Sdp/R9+P0fb8H7ukBIpPhQIYVBDMMk7ClufWtdQ6qnNeIv6zyl5FVWilj0hnICaPV7wCABhW6tYXqY09PIYe1dxjBcm6E52HNV+LvXOhUp82DpoZkglmGPHMqY//LMuax3vDqXLeiDkYtDOkj1uvQd0Px/n0oOX9J4SkgdZ63oG0InfXPl0pEL5eItWQmLpl3GgIvysmHD16oDLVdNU5ewPIui1+KHToxnfFCYlZwLsbArm3udFfxtkbnZ925ZurnQIGn+xM6Vm8ZjMzmExTFCjpOaM5Qouyzp/QU5tNs3iszGY6RkWGV8IXZxNaJtRzFrkNVjQGHJP+d9IN6lwVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6)
 by MWHPR1101MB2144.namprd11.prod.outlook.com (2603:10b6:301:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 11:14:30 +0000
Received: from PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::3d7c:1798:1b2e:f538]) by PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::3d7c:1798:1b2e:f538%3]) with mapi id 15.20.5293.017; Wed, 1 Jun 2022
 11:14:30 +0000
From:   "Mohan, Subramanian" <subramanian.mohan@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>
Subject: RE: [PATCH] PCI: vmd: Use devm_kasprintf instead of simple kasprintf
Thread-Topic: [PATCH] PCI: vmd: Use devm_kasprintf instead of simple kasprintf
Thread-Index: AQHYdR3Tp8Htu1XVkUWnASKhV7DpSq06ZPhA
Date:   Wed, 1 Jun 2022 11:14:30 +0000
Message-ID: <PH7PR11MB5862B80BADAFD6A16C56B476F7DF9@PH7PR11MB5862.namprd11.prod.outlook.com>
References: <20220531132617.20517-1-subramanian.mohan@intel.com>
 <20220531183920.GA770895@bhelgaas>
In-Reply-To: <20220531183920.GA770895@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee2ce9ac-bcdd-494a-aca1-08da43bfe5e4
x-ms-traffictypediagnostic: MWHPR1101MB2144:EE_
x-microsoft-antispam-prvs: <MWHPR1101MB2144141DF7BD775FA3E51263F7DF9@MWHPR1101MB2144.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uEF4eHWRfe4nv9+FSSgk6cp2DfJrTYjgMrI11GDqb6/hJlJ1KTGRqHlRFU73DK/1k8GaWq/1To3KOX3pUAmAHTYFvJKESaRHBc9Oii+kVRM3P28uLmmWJIdjkVHxoyEnzkUbZnsED9oW+QO5fhZNSD5C0a9bgg8UKxawsHMXDoqnwSEuB1OUqlxBmddPYPNErCGduQu52h9DCcgEB8cW/Pg31myynjx6Jn6QeH2bKcy42BIvjZnO6cbdppMxh4NX/7wyVT5isGRBkkUvGJRgTl9R+E2fA5yyz0qX7ogGapWyG0hBx+R6Gb2AziBr593sff57dCYZBghaFE67lEWscF4bWitCIabdstXT1qt4IMjUnAIOMPEuXxfYLZpSKGLhFF0VyuqYrgP591mZkzH7DKDxDlioEpprDdcRRdnjU1p+XI1kfmOUnN4N0oTnULMNj/QIn4Y1YYfSj75sfckp9B1AVYgA1wqMhbQQRZ03xHzJTPeW/bjzSQaOsv0QfFtSVCdWcujMB8tw5ukm9z94EyD5ceXvkHCG2kU5Lzky9q2nSGg235SnOwAsh5vODXOnlSgn74b3BI3cNEcf4Nh7l3xiIlm+1dW+tz6bXaGRpfabG5bA2uBVvza8b0K5A3IDqnnLFBM36E8F1SzQwh+ue1zKKyMOJcbuGknsxE35O62bllD30UmQcfO12ndw8I68UinqHh1r6Mr7rsi3UQQZLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(52536014)(55236004)(53546011)(66476007)(6506007)(7696005)(66556008)(38070700005)(316002)(66446008)(71200400001)(5660300002)(38100700002)(2906002)(186003)(9686003)(26005)(54906003)(8676002)(33656002)(4326008)(508600001)(64756008)(82960400001)(55016003)(76116006)(83380400001)(66946007)(86362001)(122000001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?18/N1dXiUusEexhiRrHHc9YDhgL3RCe1+lztp/cECP+XVdu74Ke6AQImMAVq?=
 =?us-ascii?Q?LaSCFyzgNRyb4OHRwmVpiHyzvk6u3GNqZH9zZuQeNnsJZNUqQKpDHG4mI8ED?=
 =?us-ascii?Q?nou/9yk3L9Rc0FI3l6QP65Ur4yvwCUK+ZVWV31XEzrL5hbZ09xJqq3OH5fA6?=
 =?us-ascii?Q?SeIlkvuXo9ZinM39cSFdSoaC1TC5tfJB9t7qarfp9T/BFI+MalyP0jSmOXoK?=
 =?us-ascii?Q?5v6SzDakfjwqDzaeYDcy6qiWQgwn9doWzzfvwqisMpXtLnj8OBRabN9dKl/n?=
 =?us-ascii?Q?IY0RvAtDCiSsqpCQ+W4u2ZCXJHSPZSQWURMrkv1PPYe3Jty/o9u43V2DQeVQ?=
 =?us-ascii?Q?3FLYZEGQC5wKuOZuRPaTMgBkUl4FDdvzUiWxp3vlOnJStmBHq3osm9CNhlSD?=
 =?us-ascii?Q?hRlqkl3S9jmBm6UGd78IOMPr/FEOG8wvCsLPN0BBU1B2HvVfzAg3H7ZnayQw?=
 =?us-ascii?Q?ybmJri0AGs71ucuSZ5mz4+VmVaLyiUyxaThQRkJ4Vd7LAWq4vNq50SVbCiDJ?=
 =?us-ascii?Q?jyN6nrBtP4qZQ8zRyu/xkXPSM02WbcOrbso2ZpH81Yk3Ii8+rxCgsXXiB+do?=
 =?us-ascii?Q?V8lpsgoafGKauOkrAX9aq7OXE1eBDRy6vY25QQmq3k6l+5np/jEROHo+2sV8?=
 =?us-ascii?Q?9hhBy36GEEySKhNdTBVebiFwmuQuFUrJrJaWvJ2JtlxhZIKPVkGwmtThQZxC?=
 =?us-ascii?Q?lIhkZuCoCkFUpoyaubYs0tlxgEWWJ4WB+VGpCb6t31YbDRSaxBweqmNu7LZz?=
 =?us-ascii?Q?WyrO891wVmbp4JC6dnkCkhq6m4E5G8npbdLG6XLNkinNlN7SiJaBW3A0tKqR?=
 =?us-ascii?Q?JL8/J9wfSoJsdvO5iyeRZPjQPmFh4CtiVDl5aZdpowB8B07lGpyZ9u7mfYN+?=
 =?us-ascii?Q?GACPGLmXheDf4BMGuYD7l0XBT7GDqo7xqriXI51YucNBzzjIhoKtxoIKEb+J?=
 =?us-ascii?Q?KGZWIorbhYW8joW1Bd73zERATASiK3Gg6sulT7GPuz8hRuZedR1Vib8n/XGc?=
 =?us-ascii?Q?6W1f1d5S11y4zJWNEQYAzQ+hpnIQe0DSpInY383cU1CZmmAslCkWOqgtCF8H?=
 =?us-ascii?Q?j0aLDoE2Bjo34byrStG9AF4StcNY6pN7DfZiW6xaow/NIFwUwLuNmeg1iSYF?=
 =?us-ascii?Q?f46nbs4S7XZ/b3gPIMPELHueoSep4sV+7CEKwm6lhW4YEc1MsowZsvR0oa+M?=
 =?us-ascii?Q?y76J4a0i3Od4l0PUfT2hL9b58hGKeNk2OVfToOXKCIrv18PDwHRrGUGctqJt?=
 =?us-ascii?Q?DWTBeFEDwgKTaAsotbc+PCsWvVnfjULCMA5N/xCeQpyuWhiYwUUhURyPoU+p?=
 =?us-ascii?Q?0kflqYn+kJ8cZmAsxif43777LNwXYTGHESNow6oGoCoY4UcPD7MQxxCD/soA?=
 =?us-ascii?Q?iTijZTdADAuJ8EsiMbq/xNgKqIk8WEorrevvGAeOzsmugPLQJ1Bj5y0ksbbI?=
 =?us-ascii?Q?MPcHl1YMjpMBQ4aafxognEsoJZ70NFqR9URyvqBFVxnbuccSYjaNcHsLWoao?=
 =?us-ascii?Q?bRf5UGUgFURtNlg7H9Vvid/iZUw8+Au9RmyNOgHDzxFDcXRDphM5z6SwmzUj?=
 =?us-ascii?Q?bcAwgUTHIuuPKa8A3eAxo1++zwa9v2q6EEReMIie+H/hWlSyrjvpgjUYNVsR?=
 =?us-ascii?Q?YLLkcMVsbT26GwEKJBgeXR+AkvifT0sdk+HBsLjIfWvHj942SaK0tHgaOKVe?=
 =?us-ascii?Q?PSckdY5sy5RNCPfomFHnpPZnxiW5YJCaUE72jXBk5Sq5/91xypynnCJ/DEbF?=
 =?us-ascii?Q?XTmq1RJPPaZHY8bcA9Z1G8sJUTE3wLs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2ce9ac-bcdd-494a-aca1-08da43bfe5e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 11:14:30.0661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcBYuseU0PZhC62+9z44xqhzcq/dlSRVwasG9uCUlCp1YQNPEQSp3Ufm3tM4L8M/G/fCX7n9S2EraCU6lJ525KSZLVBoMreLmoLyc9i23Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2144
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, June 1, 2022 12:09 AM
> To: Mohan, Subramanian <subramanian.mohan@intel.com>
> Cc: nirmal.patel@linux.intel.com; jonathan.derrick@linux.dev;
> lorenzo.pieralisi@arm.com; robh@kernel.org; kw@linux.com;
> bhelgaas@google.com; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Thokala, Srikanth
> <srikanth.thokala@intel.com>
> Subject: Re: [PATCH] PCI: vmd: Use devm_kasprintf instead of simple
> kasprintf
>=20
> On Tue, May 31, 2022 at 06:56:17PM +0530, subramanian.mohan@intel.com
> wrote:
> > From: Subramanian Mohan <subramanian.mohan@intel.com>
> >
> > Use devm_kasprintf instead of simple kasprintf to free the allocated
> > memory automatically when the device is freed.
>=20
> I guess this is pure simplification, not a bug fix, since we *did* free t=
he buffer
> in the error path and in vmd_remove(), right?
>

Yes this is simplification and not bug fix.

Thanks,
Subbu

> > Suggested-by: Srikanth Thokala <srikanth.thokala@intel.com>
> > Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
> > Acked-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > ---
> >  drivers/pci/controller/vmd.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index eb05cceab964..7a72948e001f 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -897,7 +897,8 @@ static int vmd_probe(struct pci_dev *dev, const
> struct pci_device_id *id)
> >  	if (vmd->instance < 0)
> >  		return vmd->instance;
> >
> > -	vmd->name =3D kasprintf(GFP_KERNEL, "vmd%d", vmd->instance);
> > +	vmd->name =3D devm_kasprintf(&dev->dev, GFP_KERNEL, "vmd%d",
> > +				   vmd->instance);
> >  	if (!vmd->name) {
> >  		err =3D -ENOMEM;
> >  		goto out_release_instance;
> > @@ -935,7 +936,6 @@ static int vmd_probe(struct pci_dev *dev, const
> > struct pci_device_id *id)
> >
> >   out_release_instance:
> >  	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> > -	kfree(vmd->name);
> >  	return err;
> >  }
> >
> > @@ -958,7 +958,6 @@ static void vmd_remove(struct pci_dev *dev)
> >  	vmd_detach_resources(vmd);
> >  	vmd_remove_irq_domain(vmd);
> >  	ida_simple_remove(&vmd_instance_ida, vmd->instance);
> > -	kfree(vmd->name);
> >  }
> >
> >  #ifdef CONFIG_PM_SLEEP
> > --
> > 2.17.1
> >

