Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4664D149F2D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2020 08:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgA0HSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jan 2020 02:18:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:35724 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgA0HSa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jan 2020 02:18:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 23:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="260955504"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2020 23:18:29 -0800
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Jan 2020 23:18:28 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Jan 2020 23:18:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 26 Jan 2020 23:18:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQJc7NEQGLltKPAc9G/lpFh9CpFTD+kevZd/BbaSgPbR3zsB0PqkaqJGxHQUTFn3xsPwkUxzIf/y4LGUnWiiLwpEhXaKmROFFUy0J59vp/ezpV8nSvDIEanqJahdcY+OAaWTvzSwgOfZGLzmfryr3UadL9tWr6pZOvRvNnJHa1YlxBYvYCEOMmQ9jbQD92/QSJmNZKFvTWq2It+NQHBCUAgZm/SFWaKzGeh4nagEuVVbheHBiiQByl9Dz4ycAjVWa0NRJP1LphtEpFG2vm4p6Esqpl+BWLUTAbUbzClOYAjlnxgQWo4zPvGRf8f4+8NR83d7/VionE0z2dcwXO0XjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWDEpSDs5uXICe4hDRpfi5RrtQUdYSTHa7PyGunXDLE=;
 b=MRtp+y+fOLutInWHqW+2cLKDF4QQUfP3WmZYaGE7lX7+9RqmLnnIuFuZWLNyCgmofWPunNnlzhS+4J9fmAME5Q92RIM0A/9Ek1EtevLnwlLPvRWd13bRQdK29GE8f9X4l5YibdE+SpDGgyOji0Noj3tDDp7qtWlocloZk+8ksFInIlVizZDDWJ/M7Y5Hs/h1gPR76zznpnQbL/zdW/2eF6roItvnETwvpS8OEcwW9ltRuAVDJwhMn0K0t81SCir+9gA4x4tugpe6smtT4562YCEJIIztdkiH0URq0lMo2nXi69ZBqYLSHRngAJmMAUkU25isX3xWN3xyXRFDp+dlag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWDEpSDs5uXICe4hDRpfi5RrtQUdYSTHa7PyGunXDLE=;
 b=IMgsz7f9J2zibvUDLgX2R7rIgsnyNzPPPN9c74LgMMFGMrsOthnFiny95lNMtcdC8GuUCkLuidK11+2E9FpVlLcrDIvUMR+HOjvvERRbF0pZNrjQNtje5mawNbo9bT+/MkiOXNLhSPN6SpPCeAzTQrXPyVzh+rSBFwO8ZAPAux4=
Received: from BYAPR11MB2917.namprd11.prod.outlook.com (20.177.225.216) by
 BYAPR11MB3319.namprd11.prod.outlook.com (20.177.127.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 07:18:27 +0000
Received: from BYAPR11MB2917.namprd11.prod.outlook.com
 ([fe80::e91c:4b6e:321d:cbe8]) by BYAPR11MB2917.namprd11.prod.outlook.com
 ([fe80::e91c:4b6e:321d:cbe8%7]) with mapi id 15.20.2665.025; Mon, 27 Jan 2020
 07:18:26 +0000
From:   "Skidanov, Alexey" <alexey.skidanov@intel.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Heilper, Anat" <anat.heilper@intel.com>,
        "Zadicario, Guy" <guy.zadicario@intel.com>
Subject: Disabling ACS for peer-to-peer support
Thread-Topic: Disabling ACS for peer-to-peer support
Thread-Index: AdXU3xN5Q2BD/xtgQwWkaPIJp9pGCA==
Date:   Mon, 27 Jan 2020 07:18:26 +0000
Message-ID: <BYAPR11MB29171883468FD79722FF3652EE0B0@BYAPR11MB2917.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexey.skidanov@intel.com; 
x-originating-ip: [134.191.233.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d28f1fed-828c-467e-19fd-08d7a2f91a5c
x-ms-traffictypediagnostic: BYAPR11MB3319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3319430F844D498404B5807DEE0B0@BYAPR11MB3319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(107886003)(5660300002)(52536014)(2906002)(54906003)(55016002)(4326008)(7696005)(478600001)(33656002)(9686003)(86362001)(66574012)(81156014)(71200400001)(8676002)(81166006)(8936002)(6506007)(66946007)(186003)(76116006)(64756008)(66556008)(66476007)(316002)(26005)(110136005)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB3319;H:BYAPR11MB2917.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XqLY3xBptl7kIYnoZ9qybQOEWh4FedD8tDYRenCF5LXA99uZXRpite8moo/2B4J5EG4XxutF9r64uqb/o9nGFoXpiaJFfkFwVebGKhNNlqfCXJeZrzI037nV/hJb3Uu/NiYIWv6kCt4x9PbhxUmJgAFbz3+Ynh98515+SeL3OEc5TgThfEXbs0FzsFrFoUHaH+0KqbuuBuRfNPopeSuX13IB36c3CnFwTPqkjeSlDueVCyYFHko6VLKTnb7B5bnC+IfHuP0EIah+Wfqzlvdzk8gkaC5TCCWjQtyOA1Xvx3RafZtih0TgHzMMdM92WMbGRaY76Y7EgJZc1sJGEA1Mk3OsLEzpr2DCfuka3TH8ZplW/Rpt+Wzw7t/Nwt2gxGL1WE29aTwyHrFfo2U84ykj8Gx1SRUpUTOlmFNARAZxwzFJQN4opHdPesTBzpTZ3swo
x-ms-exchange-antispam-messagedata: yVTaNQDsKAD907sFlgdt6+e3ChbnKTjxM9l27HAcrjwkv1iWTNOcVmLOVW4rmYJBef3JAfAQTogIW8HrF8fjjHhOkE54GvkbVeJMBWCxiEgpIor4Ly8B4OG8IeK/LNI3Da40BDZXciZeE2nV5rlwDg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d28f1fed-828c-467e-19fd-08d7a2f91a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 07:18:26.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuErOEbuDYGXcAyT/QHJ9voG2hPu0DMutxleuwVnxe3w8TRP+s2hda9/WA6CI5VFktnnl8uwYJXsHanKT24p/qM6vgWlZf/WYeKoMgtmty0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3319
X-OriginatorOrg: intel.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I have recently found the below commit to disabling ACS bits. Using kernel =
parameter is pretty simple but requires to know in advance which devices mi=
ght be participated in peer-to-peer sessions.

 Why we can't disable the ACS bits *after* the driver is initialized (and t=
here is a request to connect between two peers) and not *during* device dis=
covering?.

Thanks,
Alexey


commit aaca43fda742223e4f62bd73e13055f5364e9a9b
Author: Logan Gunthorpe <logang@deltatee.com>
Date:   Mon Jul 30 10:18:40 2018 -0600

    PCI: Add "pci=3Ddisable_acs_redir=3D" parameter for peer-to-peer suppor=
t

    To support peer-to-peer traffic on a segment of the PCI hierarchy, we m=
ust
    disable the ACS redirect bits for select PCI bridges.  The bridges must=
 be
    selected before the devices are discovered by the kernel and the IOMMU
    groups created.  Therefore, add a kernel command line parameter to spec=
ify
    devices which must have their ACS bits disabled.

    The new parameter takes a list of devices separated by a semicolon.  Ea=
ch;
    device specified will have its ACS redirect bits disabled.  This is
    similar to the existing 'resource_alignment' parameter.

    The ACS Request P2P Request Redirect, P2P Completion Redirect and P2P
    Egress Control bits are disabled, which is sufficient to always allow
    passing P2P traffic uninterrupted.  The bits are set after the kernel
    (optionally) enables the ACS bits itself.  It is also done regardless o=
f
    whether the kernel or platform firmware sets the bits.

    If the user tries to disable the ACS redirect for a device without the =
ACS
    capability, print a warning to dmesg.

    Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
    [bhelgaas: reorder to add the generic code first and move the
    device-specific quirk to subsequent patches]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Stephen Bates <sbates@raithlin.com>
    Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
    Acked-by: Christian K=F6nig <christian.koenig@amd.com>
