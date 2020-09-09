Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67C8262550
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 04:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgIIClR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 22:41:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:29124 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgIIClM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 22:41:12 -0400
IronPort-SDR: vy+PemRLhu+quuvxUmUQ9gq+RiWclY4jSjcRf17VmB+Amgw8bbQgSJp6YeV0yO5avEy/k98ko/
 t4ZTKhgurZQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155659294"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="155659294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 19:41:12 -0700
IronPort-SDR: ONobC3Pu7Js9+iTPkSF+6bXLZFA44kr1EuVIrpG8LDvRLzwrKNCuRibjU3fRuxeucdbCBVTQZq
 9YpFeK3Ff8Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="480291764"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 08 Sep 2020 19:41:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Sep 2020 19:41:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Sep 2020 19:41:11 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.51) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 8 Sep 2020 19:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMBOugqT4vemq9TWNz1ULROlsqmCclhhag9YG/CIX4+c2Ei7gEFOjMCpuDKyrdcgTYV5lD1gqRAJTaToVnrFdT5FdOl4gQbFhTL3/0C6LaFDhCjKmtAB8HbnEVWXFUtLKghA/iB2wd8yL+HQWCrW523S3LKC6BgUoxFxgoGR5XFMIz6Vcwisy88M+1kJqrozghJPgYnyGZu4PUFl78WZ4rELtFmP43eDxffEsJI62BxXLOoinqixRLIZyygl+cnh/lJ9L27Yv5oGqPJFDG3tcenLnUrlLU+KZYgIRXcrHnOEeGPPn4sWJemoCMQyE+fhmZoNHPCY4CojfTy1jf23bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh7f1YaratsRAjIA4vL1ZnYkOW1obYn+Qh9fsznHGUo=;
 b=PsEyJlN1WBVUipU2/P0nG9MSFMRHeSzypFIodL7rCzEAwE9nxcyzhxtnAUA/ftbwjciEKWznCGadGWDpL3nECzaL+INGaF4Ui1XtiySnOkU6Zbo+tRoc5C5zunEiI/pgqInE19jmLg9XQTA9z6/aOrQG1p3S+10Q5pZEuUXFQ1PNwzQe2XpNEw9Zqt09Dc+kZUR0bI4bU5ERuH6aYjhdWNSLiy1LlvuhQgWDMeeoUykwlodl75UG5kkfnAFt5Y2dqfmAoyKPkvHs4UWRurZgFo0W5llvkpElwCB0S8/5Zd6UgHxKnLKnVaIfWfQ8xUqm9JEA7OTkq9fuXr1bQTTWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh7f1YaratsRAjIA4vL1ZnYkOW1obYn+Qh9fsznHGUo=;
 b=uR9qzCZyBQ2lBL9nYIHj+KWv8o/mkIaosXjvsiNX5k1+pqFvs+2pvGCjgY40YcNX+K2kCwQtpV0hKWdpZ7e1WlUzoWgoKLRpdGszihvTxL7uTslkPMhHJOFg9bM7aymP8nUdUPI2m/2pRQRRoVbpnCgE2gPkJlOBvEsG8yQt/rY=
Received: from MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23)
 by MWHPR1101MB2175.namprd11.prod.outlook.com (2603:10b6:301:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 02:41:08 +0000
Received: from MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::ec4a:90cc:bdb4:5a5a]) by MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::ec4a:90cc:bdb4:5a5a%9]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 02:41:08 +0000
From:   "Zhao, Haifeng" <haifeng.zhao@intel.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Zhang, ShanshanX" <shanshanx.zhang@intel.com>,
        "Jia, Pei P" <pei.p.jia@intel.com>
Subject: RE: [PATCH] Revert "block: revert back to synchronous request_queue
 removal"
Thread-Topic: [PATCH] Revert "block: revert back to synchronous request_queue
 removal"
Thread-Index: AQHWhbUmn1JF/TbogUavgTta1QMeJqley0QAgADEb6CAAAm2AIAAAGQg
Date:   Wed, 9 Sep 2020 02:41:08 +0000
Message-ID: <MWHPR11MB16967EE0DEBE2BBE23D3748A97260@MWHPR11MB1696.namprd11.prod.outlook.com>
References: <20200908075047.5140-1-haifeng.zhao@intel.com>
 <20200908142128.GA3463@infradead.org>
 <MWHPR11MB1696A6C649BD434390418FE797260@MWHPR11MB1696.namprd11.prod.outlook.com>
 <20200909023918.GA1473752@T590>
In-Reply-To: <20200909023918.GA1473752@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f42aa85-4702-4e8e-f7dd-08d85469ce9c
x-ms-traffictypediagnostic: MWHPR1101MB2175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2175EB418C5953B8C75862C797260@MWHPR1101MB2175.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPATqRBAlWrq7fNWbfq54Suv7X6GSLJCgjedbkk1s7oEqMuuIqLe53BeI3MvmAKeuY2xK1P51tq1Nq2sw6jJbUcobHOIytv8xW3UsV0lKP/uUFkRzfwVDI6ifHzZhzsoj2XxuSqMGRQKETwBHL+f+AjjB8VXVYjHZPn2a2B0xuIsHMtYa2aGYXtTR/mYlOazXbzTIiBlj/iMrNXQmQRZ/aoASbXHmwwjK2rPBdRkboVuzZDAVRnpzFNY96HgeVGwLEZxrn1jntvc02pUN//J5oQ+ID7nDeot2/RgSjOolZZYPLFPCElflwyveYrpCGLDvpPLYGlzPk6D+VhAp+NHxkQX8FiVRPtbPS/Q3IZ6meS/p1SBc+UBGNZDywqf/2a+qY/iv/1xqXXb9/P3hGFZ0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1696.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(4744005)(9686003)(53546011)(7696005)(66446008)(6506007)(64756008)(6916009)(76116006)(71200400001)(66556008)(66476007)(66946007)(86362001)(107886003)(186003)(26005)(4326008)(5660300002)(2906002)(54906003)(8676002)(316002)(52536014)(966005)(8936002)(478600001)(55016002)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JRqRwzoPIGBoqJYnSQqtkPi0sI7kH7knaw0AxxprAuWAjthkStvVjxtoREvuJB78y9ZTMHmMDbfnOTHgcfe9aT6Iqbsmbj6LwI9ojcR9jFzQrTFCEMf+8sPqYiOPGvq7TOp3Xng7cItibs0zcGV3QuVIx/ZnarEmHCp+WA35F2NVJ4O1MeSwhJdjTE2301/3ls64VZLNIV5huz22GrcFtDmVghJWZ0UpSEPAhKG0xRQGH0NOML/ROMyZxoaerb13RqfZ4cmdyqXn0E3hHe87OxNsLxqOdUR/2lSwxwpVM9jb6WD5c5WdDkbK9z0dbhbE3JdmfL936u4bta8jDJNO9nBFmbdIAhevfom7B1lfnvchh4+7fw/oVVe7fWEIn1ynyXHxXTzxRFoW3Tgutbonso32IKbNWUNLljYTKzAhUoWc0e8zENOkAXuzmPQwHZ5FXD/Rd200FmzAp6QAvekDRMs2lipzaUyVUS31tGiI+T9lISdRvf5QQrBZN/i8Rqc4LJpMxPMTIIe6tfa/WTVi972SVfaaSRoa75MfL23ppjvW+I7WiZfh1la5a8+50KjXmr9pkn1NALgI8xwqraW50ubOz+M6/T7AdG5niYXrTHHBons6HW323+FlMz2mPBiGpg0OPfBSejtMudUxUucUng==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1696.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f42aa85-4702-4e8e-f7dd-08d85469ce9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 02:41:08.6288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKwM9bsyKgiGY5hcpdHqLXUTi10SordYLi5IqFYCsZB6MnVGHKbzVMer6TMs9ufzVV2EzPT9ZNmvz+VgGMyuEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2175
X-OriginatorOrg: intel.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ming,=20
    Got it, will try and give you feedback. Thanks,

-----Original Message-----
From: Ming Lei <ming.lei@redhat.com>=20
Sent: Wednesday, September 9, 2020 10:39 AM
To: Zhao, Haifeng <haifeng.zhao@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>; axboe@kernel.dk; bhelgaas@google=
.com; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; linux-pci@=
vger.kernel.org; mcgrof@kernel.org; Zhang, ShanshanX <shanshanx.zhang@intel=
.com>; Jia, Pei P <pei.p.jia@intel.com>
Subject: Re: [PATCH] Revert "block: revert back to synchronous request_queu=
e removal"

Hello Haifeng,

On Wed, Sep 09, 2020 at 02:11:20AM +0000, Zhao, Haifeng wrote:
> Ming, Christoph,
>     Could you point out the patch aimed to fix this issue ? I would like =
to try it.   This issue blocked my other PCI patch developing and verificat=
ion work,=20
> I am not a BLOCK/NVMe expert, wouldn't to be trapped into other sub-syste=
m bugs, so just reported it for other expert's quick fix.=20
>=20

Please try the following patch:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dcafe01ef8fcb248583038e1be071383530fe355a

Thanks,
Ming

