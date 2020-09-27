Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC5B279F13
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 08:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgI0GuG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 02:50:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:50721 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbgI0GuG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 02:50:06 -0400
IronPort-SDR: pZ1fArZXhUZJj9a8O0Efq2EtXv7pGDMP0oA9XR3TpVlBpYLdzXcDaZExLhgsSL+KrVGvJ61OGD
 tzbjKxlUVobg==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="179993895"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="179993895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 23:44:03 -0700
IronPort-SDR: hi4oVSEhvPRKLEwj4kL111opLc06KPbY8jua1PcQu90o4J3uFhPycBz+tUSVMRTrNUK6YzmBN2
 8JxhI4QYCjcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="323924770"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 26 Sep 2020 23:44:03 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 26 Sep 2020 23:44:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 26 Sep 2020 23:44:01 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 26 Sep 2020 23:44:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=effSecTRRcpd454Xsz079qP91zrlD9HrydaZ5ptzSqdtWNd2OOkYf/9/ZWktMdvia0p1vG/XlOKXnWY6w3ofoGVjs3IJmhiq3qYIMa14BVrJDppJydLwny38K3smK28q/F15Eesq/brJ85hGSx41llTG3QvqezCntZCDt+/xZW2GD4K29RVJp3yHR4b3zu4EjTcuJOpzzZ2VWDosKRzYf/96Ch+R8hTAXFaxMv+DMu0Azhqo4K5lIpclwfscM0lzMYsHdklK9qih7gSzge3XryhwscDDcGhSgtSc+rgFX9r+GYp3Q2Ig25HKAQT7n8Lu9xEu7cFaG5ik3sCxiH72JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbSVpKBHb5KoLltAIFCywRTkwSERJWMf0QaN1821IVk=;
 b=lZ2CGb2IHkswhIjgVHxTiiFJdI99SRMTlUbDr4+rudsuW2oEKc1feA7At6UOtlpY3FFyB8tf7bTQav884gzXAe2oDnpL7DSX3aRLnWDbG+Zzga92ZyBBkn6dHR1XAddRDiEnMAk9VlB2oYFlV/0LUmKlU6/iUFB/OigYO5tIn5BDwrHWEw6Ase1PROpceGG+GNKGB8j9a/3ia0lRE0RryVVrIKP6yDCTyo/W+DH5hcghd+ivYDdfDHNESvrH/C8hfx0FctpJCHxzo1YmiEdCvTKnUPi1b80CxZfmQU94ZeCsPaITD9jEGrnr8NP416q5ytEYFgEMrMxUowym7sbxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbSVpKBHb5KoLltAIFCywRTkwSERJWMf0QaN1821IVk=;
 b=LjlaKy8Oy0TLAb3GqdUHVtcW1bKMwEc2+mvW+J2vPRdlClM4QCPb1iSKqtN928Ew5I1JOKFOvmYB8QNfz6G1/+jOyGS1VRPYh04SyM1egywehaavgBbhTgTIQaJG5/cwl8yYz4pQ0YIgyi9bkLWFgCLNsmCBI0G7uYSScZ9tFjM=
Received: from MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23)
 by MWHPR1101MB2270.namprd11.prod.outlook.com (2603:10b6:301:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Sun, 27 Sep
 2020 06:43:57 +0000
Received: from MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f]) by MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f%2]) with mapi id 15.20.3412.025; Sun, 27 Sep 2020
 06:43:57 +0000
From:   "Zhao, Haifeng" <haifeng.zhao@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        "ashok.raj@linux.intel.com" <ashok.raj@linux.intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Subject: RE: [PATCH 1/5 V2] PCI: define a function to check and wait till port
 finish DPC handling
Thread-Topic: [PATCH 1/5 V2] PCI: define a function to check and wait till
 port finish DPC handling
Thread-Index: AQHWlH6I6XnH2EYAHE+QZzgIhMgsKal8BJSAgAAFMNA=
Date:   Sun, 27 Sep 2020 06:43:57 +0000
Message-ID: <MWHPR11MB1696E70F1DFFFD0F1B1AE55297340@MWHPR11MB1696.namprd11.prod.outlook.com>
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
 <20200927032829.11321-2-haifeng.zhao@intel.com>
 <20200927062359.GA23452@infradead.org>
In-Reply-To: <20200927062359.GA23452@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ece3117-7894-419a-5fc6-08d862b0b5b0
x-ms-traffictypediagnostic: MWHPR1101MB2270:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2270E4E7B238A0511F8633A497340@MWHPR1101MB2270.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N1uSZpU8ESuhR57OY5eQwrPbwf+bAZsmcqkVPr+ucQpEWB+rjUvlSZL56wvStpmn2l4dmb0q0nSzC09nEsKD8XfXC3UdYJ8fkKW2OvTkQoaPzquX0QJAoIwWlhEDDOEffFubG4ZIQYvJAK+A4XJeHIh49kwJtnrm0/pKznx0iybK6Iu8HbCRUfaeRWc4a8/8+HYzuNmDFcJfV8S9geEHKV3dwORRK9wo0bLHREZrKDUg0aAQhwF7DIaFfkjPEV7qOB1l0SU1sg3/5TyyjPPoWun/+rZM1oVT2egJwSKt32BP0LWGxO1hsVX6hLTYhWM2zMSBSz5f+j66VaBtrP0NNPYwbAoR1gOWfXo7hMmOstDBbTJPK3T08VdZzpmk8a7U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1696.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(52536014)(83380400001)(5660300002)(45080400002)(66446008)(64756008)(66556008)(66476007)(66946007)(71200400001)(76116006)(33656002)(8676002)(54906003)(316002)(8936002)(478600001)(9686003)(6916009)(55016002)(7416002)(7696005)(86362001)(53546011)(6506007)(4326008)(2906002)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: O0vNlDcbpoh2edIoMKgEEnrPKj2ApkjeRyoEED5/TNgM1mRUQxsDBEnDyxRjJC/JlpGnnHerVehmYdhw7f3HKlGVgyrN8oHfoaYQdSRIjWtTa6eugvuaNfW7EzQg8Jg7JVezh5wwj8Wm/NsnSMbg9OALycipZEL92WzViH0Wq1vd+sMPkF8iaka6IT6LFB+49M1hKokiv7fXehQ6BbfXKeAVi0fprsThrNmeH5JDO/R26VzDNbigdCyQYHI+FSVjfmxYo0JBAgCEhuOTe8WB53nO7ohcrqiU/+d96elqWWzVePTPTSt5kC16twvGab67sc60Kg30AjM0FcusU4fOgKtBkpCm5xu3jfVFWiyR9jIwzoWCSKNopPbS8hoExyyo4q0U8qBzihLwKbU2mTmykFrZ03Vv5oO5XVdKDV6FFbP9j09p1CmffLqzb18Qmg7yJ/G8g4kGFEB+FYcsTHkcEXF+CBbdH2qWTl07wE5P3gm7CSQnPLUnyVNZW//wzvaLQN5laGxERKMIW/jTTGt97LIhJhqvWrIklBA4wuu/pG6QHJ4fUEYigPyAvVvuaTQsV8YU6e0tbqAJqhr3ZZ9k908PE4S1lsBjAyrNDMEZ322pDMglAfbDe0/gKLYMbWvXhHLKjHkqNjTfxcl21a6OkQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1696.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ece3117-7894-419a-5fc6-08d862b0b5b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 06:43:57.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EH3iHNpdaj1tXkjKsSOfz/+5+y1GywdvqQ4lvVbOBo/SS82KBfogP9mEZSEkzuoGd4FkJ6I4PNGxC1HJ3PGjpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2270
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Yep, I am think the same question, is there any other files better to put t=
his function ?
How  about pci.c ?

Thanks,
Ethan

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org>=20
Sent: Sunday, September 27, 2020 2:24 PM
To: Zhao, Haifeng <haifeng.zhao@intel.com>
Cc: bhelgaas@google.com; oohall@gmail.com; ruscur@russell.cc; lukas@wunner.=
de; andriy.shevchenko@linux.intel.com; stuart.w.hayes@gmail.com; mr.nuke.me=
@gmail.com; mika.westerberg@linux.intel.com; linux-pci@vger.kernel.org; lin=
ux-kernel@vger.kernel.org; Jia, Pei P <pei.p.jia@intel.com>; ashok.raj@linu=
x.intel.com; Kuppuswamy, Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.=
com>
Subject: Re: [PATCH 1/5 V2] PCI: define a function to check and wait till p=
ort finish DPC handling

> +#ifdef CONFIG_PCIE_DPC
> +static inline bool pci_wait_port_outdpc(struct pci_dev *pdev) {
> +	u16 cap =3D pdev->dpc_cap, status;
> +	u16 loop =3D 0;
> +
> +	if (!cap) {
> +		pci_WARN_ONCE(pdev, !cap, "No DPC capability initiated\n");
> +		return false;
> +	}
> +	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> +	pci_dbg(pdev, "DPC status %x, cap %x\n", status, cap);
> +	while (status & PCI_EXP_DPC_STATUS_TRIGGER && loop < 100) {
> +		msleep(10);
> +		loop++;
> +		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> +	}
> +	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> +		pci_dbg(pdev, "Out of DPC %x, cost %d ms\n", status, loop*10);
> +		return true;
> +	}
> +	pci_dbg(pdev, "Timeout to wait port out of DPC status\n");
> +	return false;
> +}

I don't think that there is any good reason to have this as an inline funct=
ion.
