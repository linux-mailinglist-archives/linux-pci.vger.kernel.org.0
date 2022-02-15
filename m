Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5EF4B65D2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 09:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiBOITG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 03:19:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiBOITF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 03:19:05 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586CB9AE45
        for <linux-pci@vger.kernel.org>; Tue, 15 Feb 2022 00:18:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNzzTr/or1RDhhevBXDiZbghYs49FIom8XJFzKE+ZpjHSC2L4seNvgCE26S6Bc8X1CTH2ASQhbJLyZTj3AM27/nJ8Ly2UujQqT55CFOJwKt0rihfiKpcS7uPNvjtPf5drqGPqw6koavEj+KK4GfOz9sr93+lZUYwSZnlR8IAAp0mDKjROnjeAEbTjKorn7qef3YehIr0OJfsNXgYnx//P022s7GXxUKqki//gwwglw/3fdA7ZIar5ON9KfxlwIcjSKgNUeLRfp02Spzsbw5wPLbA0Y5JJL2C07iiSwktgIBDwcGKb/94UDu7TiP+DajPHidG8Yy3ci+K841jhU4o5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hcgszi84oWP5RkpXSI8CNMm8wI1/qSTFqFmQIC2hR0Y=;
 b=MIbosDf5H7gBpxL1EWmcqxu/cCCMb5VPiQVQJAcHyuSGDrrqrIgYYAgDe9F6IQlILZIbXcBkP2YlYzxKwgbseYPQvo5JaElQcaPZsL7eZj42n5igTUoQFh2DC8kRuIIZR/pEOqEXqhPE0KXxUEC0u1LA0FI6Do6WOAkBKVvi/RtS1o8sylYAIQeVAYOdacojSrkjSXziP8UcedYXgJ5/xbe3sbVXgUXPbX6KX5tZXxMEGngo19woyxZzeq24esCXGjEm/H4p434w2JzgvNFQgiYREtM6d/z4MqyEL06wng84n3UhoEarpTpjMsz2N+H9NJqFCwT2lroPot/c1/wtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hcgszi84oWP5RkpXSI8CNMm8wI1/qSTFqFmQIC2hR0Y=;
 b=IWmxNvxp6Eaba1b9SHjfGzTrmhCGu1ikquP1b8ekauwBNIlYO3ZhNbgaKDy+8TP3UQU/PL5d4OG/7JRzue4cZuuLq+qcX5dXzeSTDoCdfcHVI8yUbZ1XY/3rZCYMB52t4YTw7uZ81A6JLpLlcFRcsbMvtLEABHzqRFkOBZDnQyA=
Received: from MN2PR12MB2926.namprd12.prod.outlook.com (2603:10b6:208:10a::13)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 08:18:53 +0000
Received: from MN2PR12MB2926.namprd12.prod.outlook.com
 ([fe80::9bc:c78e:4d52:2bf7]) by MN2PR12MB2926.namprd12.prod.outlook.com
 ([fe80::9bc:c78e:4d52:2bf7%5]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 08:18:53 +0000
From:   "Kumar1, Rahul" <Rahul.Kumar1@amd.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Thread-Topic: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Thread-Index: AQHYHe7NoripXS4z/k6cIS9tep+oqKyMUXkAgADxaACAAA4TAIABGu4QgAXMPYCAAAoW4A==
Date:   Tue, 15 Feb 2022 08:18:52 +0000
Message-ID: <MN2PR12MB29268D811DF79955200ED96CC0349@MN2PR12MB2926.namprd12.prod.outlook.com>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
 <20220210062308.GB929@wunner.de>
 <6da46e96-8d71-3159-d4e1-0c744fb357ba@amd.com>
 <20220210213732.GA25592@wunner.de>
 <MN2PR12MB2926BBA4DCD4D7ECCA453577C0309@MN2PR12MB2926.namprd12.prod.outlook.com>
 <20220215070229.GA21694@wunner.de>
In-Reply-To: <20220215070229.GA21694@wunner.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-15T07:51:25Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c367dfd9-091f-431d-8727-9404a4641a00;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-15T08:18:50Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 40aa53db-fc50-4797-98fb-325f807b2dc4
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61fb49ea-9594-4f11-e2a3-08d9f05bcd94
x-ms-traffictypediagnostic: SN6PR12MB4704:EE_
x-microsoft-antispam-prvs: <SN6PR12MB4704CDA35B7C5803F6D94093C0349@SN6PR12MB4704.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tuNHBQaOIlluhy+Ichmy7+FXMp9YxPzYid+nbPIWP/hfajrQgisJgKwbYn8FIXFROp/yD97tqjOfdksxMIwNnM9qM0jTOChYdAVD1aBZfSbQ2/EhqnrWkqXiNwtAJGiHFEZLlnlgcspeG2SXMmZ4mE/LvxwJPRXsXn97LgZjiWecs2RofjgTt3aW3t57O9VWya1Pe21/ApcLa8vNLsJQvWsNP7Q7mcv30dsQSRLqHib9362ONgbWnAHxYkCa9M0nGfaR+IwJB/UeQk9pkFnpbwkKJmU/hBAAN16McedCvlIGLjK6nCTEdbnsUbhLmPY5CMJsnKBRncGeZWDsfayYil+EPLjsOuWWjKrOVhKUX0aU5egG4k7tHSDp3xdNm1pDc7VywAbifYDE7PTneiRO0VmXi+XQGYATM9VdcH0gP++8tSQMpyatruhom0l9A4HU3PyOC0N0jO2AUXqrqn0k+6RUuvh9BHc0qbFkW/oSM5C9QJ4rjeZHCwxHSfsxaqusInk1b/2W3d0V15Er/k0KEMGKdH1G9jLG0wqeMa/1K2ppDr9VJX53WcvbbjsipHF7xaPUiwo1CA6iVW93HjSZym+HNUgSgX7/D95edDhV2bfuRgB0/BSuwQ0vJrq6CoCa8LiwKRNq6bGZ3qskY8Hw3XZDCTN2JFUK1B4GTy1vX+0D+Z2Ew2tMQ5lQmvQYaAc5xVJBsgI6OgDFL7JrQF9G2TnQUF9a3jtkTHmZvpAvXvMnHRLq7Rfvhh0Ygsa7TZwo+mWxT1hblzf1imlLy4k9LG/Ycvh+NsB1W8HlFtlS0FM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2926.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(64756008)(66446008)(66556008)(2906002)(66476007)(66946007)(122000001)(86362001)(8676002)(8936002)(38100700002)(38070700005)(52536014)(5660300002)(186003)(26005)(4326008)(6506007)(966005)(45080400002)(55016003)(71200400001)(53546011)(83380400001)(508600001)(9686003)(7696005)(316002)(54906003)(33656002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?03D1GY9+JYqf6sdE3pGU+APkbf1KtEjOmVSWXc8LYobhVjXNvcRYOSjedcDJ?=
 =?us-ascii?Q?rtU9GTsr142+hw8Q/jTSVbGxtAdrnE/9TNUgwUOYOWUkyyALRq/WHh+0Ge/M?=
 =?us-ascii?Q?/mp+urTGY+sqAOmrDnrVQnZbb9Pl25ZFwaKjKeXEcWIgpNJflFjLEg1AsfyX?=
 =?us-ascii?Q?xcSowzzU3gH68Icp6mHly0QIfrRLGLDDbKUaCfuc1wrncbvRTEQIO053eJKY?=
 =?us-ascii?Q?ZX0AQqDd7mFpjCi3U61phRNO7J6xYREV/076jw/QSFGow7dQA9e96YYwtUc6?=
 =?us-ascii?Q?DggEXcw8HWAi/p5JBUXNwvLujJ8FXoMt7GKIvg+N7ImfmOQhhc13Fy2V3POs?=
 =?us-ascii?Q?Ax+CRCLBf1nzY0+Ch22Io8ubAYqWFHV6N0YpJUx5mDBalHpEdxDolsnwANzY?=
 =?us-ascii?Q?6RlnI54zw6/sVlHoZKrNHIVjfocNAd418SiFAXngnbBnb3cHN6/6EjpOiXfV?=
 =?us-ascii?Q?HpdQXjo+C6oJo07mvf1MQ2Z5cA1YD7wpaet84rgVB07LfjUlspHkclT2OCrb?=
 =?us-ascii?Q?b/jYk91p5yLf+K+LB0tfgbt/tHoWAmAzIT/eBQQB3c3QHbuFIE+A9CeEIeHP?=
 =?us-ascii?Q?gbmIFHJ6vWAozCf6W2rCDG39d6/SMUA9Ib/EEpNO5V468nsh9/kEYufh3IWE?=
 =?us-ascii?Q?yaHUYyTKzBIl885yy1yExXOxdm4m1esGNQctMHDWYxwFddi01HHUCaV5awDn?=
 =?us-ascii?Q?rqt3UO7FKg2OxAlHIDpCaothjIaVSTJJCsm1lR1Lmc4XTLrjwr7WibQHY1ux?=
 =?us-ascii?Q?xjiVXvmJfZYVq8BxsrfmN4AsIxOFt/dEPrI20EHbSLrCHawn43ONf91bvqHm?=
 =?us-ascii?Q?2g0dG9BpKU4SMVWukhf9D0OX9nrY5GC4/9ODvXwHHe7TWDEb6iCxqBYWZakS?=
 =?us-ascii?Q?j6iXtIG46d4+tJGmqNfJk/qkz27WYLoR9GZjtvrH/P/oSwEWLKSuTrlAsi4J?=
 =?us-ascii?Q?RLs1MWZ7CcyvePtdiwKKsoTKrv/QcRkbtkq2/L8Eb7nPZAVwAz1u1gLtmFvc?=
 =?us-ascii?Q?3lflua+eZYz0EIQw7r0O1GxFqWUAaiuT+X7oWx8GKtKz7yg2Yfet85zNztVU?=
 =?us-ascii?Q?gS6ScMP1pCYlyvrS7gtWzLjazT19JtHl9gzMWwKCvQhaz/pimyKAe9B2Aivm?=
 =?us-ascii?Q?xXjBREzDMNLtDyoSHRm6Mj+2AWR5hEO4aJB30ekB/F8aNkelcA2Pz1CooPwm?=
 =?us-ascii?Q?hDi7Qsswp0blpelSy9sVdnHs6MihVPOm35HU7rW1h519hqw2E0DBcPdFsW/z?=
 =?us-ascii?Q?y5GBpAFZvkLhEVMy1y8NHkBktA96+6IMn48WUT9Co7jQ3L7106LbAdRFkal8?=
 =?us-ascii?Q?L/oFxGhEna3mH6EA9+ak6DCEzA/carh4COlj31ZX5Lm2lQ50Kqf6gJbjMU5/?=
 =?us-ascii?Q?mLl0ssGUmMhPzFXKIjqaqjbsMzOL5+uCvp/FLQGmlDzvvgHfSkzau8n4Mt8W?=
 =?us-ascii?Q?lEx8Wc6T9NKMj3bPEljbXx1+V8E3ycKkZgoon+oNs8jSJga2j8ankPboq7xb?=
 =?us-ascii?Q?uM49FOfBoTIriNY/EHHZq8S3ZKYQj5c2FcqzYlJ3haTkfAN4bUY7+i8+LlEw?=
 =?us-ascii?Q?V4ZW0cHWT9YrtpptlbvhYCKkCrw8gql6dSZ4zdAjuD3JAyZAAgx93Bsjmdrx?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2926.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fb49ea-9594-4f11-e2a3-08d9f05bcd94
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 08:18:52.9850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnpNf0+elXjqdr/SDBaniUIfCxpZdj4UlOeoJ58eEOt4egObER19l6IbFMYtlnJZCkQZIMPvT92QJX4DMlqDjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only]

>>>So with the patches applied, the link doesn't come up after resume, but =
if you then reset via sysfs, it >>>does come up, is that what you're saying=
?

Yes correct, if we reset via sysfs we are not seeing this, issue. I  attach=
ed lspci and dmesg logs with taking all three patches to Bugzilla.

We could confirm PCI_BRIDGE_CTL_BUS_RESET bit is set after resume, and once=
 is PCI_BRIDGE_CTL_BUS_RESET set to 0 we are able to access the link.

Looks reset command doesn't complete properly due to some timing issues in =
pci_reset_secondary_bus , will comeback after analyzing more on this.

Best Regards,
Rahul


-----Original Message-----=20
From: Lukas Wunner <lukas@wunner.de>=20
Sent: Tuesday, February 15, 2022 12:32 PM
To: Kumar1, Rahul <Rahul.Kumar1@amd.com>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; linux-pci@vger.kernel.o=
rg; helgaas@kernel.org;=20
Antonovitch, Anatoli <Anatoli.Antonovitch@amd.com>; Deucher, Alexander <Ale=
xander.Deucher@amd.com>
Subject: Re: Question about deadlock between AER and pceihp interrupts duri=
ng resume from S3 with unplugged device

On Fri, Feb 11, 2022 at 02:42:21PM +0000, Kumar1, Rahul wrote:
> We can some changes we can see in lspci from working to non-working=20
> case. Below are changes Link Speed =3D  8GT/s  -> 2.5GT/s.
> DLActive+   ->     DLActive-
> BWMgmt+   -> BWMgmt+
> PresDet+ -> PresDet+
> EqualizationComplete+ -> EqualizationComplete+
>=20
> Also when we do reset via sysfs, we don't see this issue.
>=20
> I have created bug here=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D215590&amp;data=3D04%7C01%7CRahul.
> Kumar1%40amd.com%7C6064d47163b545798e3508d9f051227c%7C3dd8961fe4884e60
> 8e11a82d994e183d%7C0%7C0%7C637805054005384810%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000&amp;sdata=3Dw4WTYpduf4brVLx14ADw7yh511Vjf5v5rVtXWjxU7AI%3D&amp;reser
> ved=3D0

So with the patches applied, the link doesn't come up after resume, but if =
you then reset via sysfs, it does come up, is that what you're saying?

The dmesg excerpt Andrey posted shows an AER splat after resume (even with =
the patches applied):

[   69.684921] pcieport 0000:00:01.1: AER: Root Port link has been reset
[   69.691438] pcieport 0000:00:01.1: AER: Device recovery failed
[   69.697327] pcieport 0000:00:01.1: AER: Multiple Uncorrected (Fatal) err=
or received: 0000:00:01.0
[   69.706231] pcieport 0000:00:01.1: AER: can't find device of ID0008

I suspect the Root Port refuses to train the link due to that fatal error. =
 Perhaps Kai-Heng Feng's patch is incomplete and it needs to clear stale AE=
R errors?  Or maybe it re-enables AER too early?

Could you attach lspci -vv output before/after suspend to the bugzilla?
And also attach full dmesg output with the patches applied?

Thanks,

Lukas
