Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE74A4E5AA4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 22:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbiCWV1t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 17:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiCWV1s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 17:27:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD6069498;
        Wed, 23 Mar 2022 14:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMOedaMgpfxuTkmRhvodDkP7RRt5d7DYQZqRV6ClgutcigHpEcg2bZ7vz2LqCtAGQKwp+0/udN54/PEaC0mR6L+gqUQ9eoTP3rHuO2zvCqNsC6NI0Kulp31x7e3BLbkYyfWsV0a4NWjwaAb9aw/eWMZP81/93BHsiR6WzluxciQDPvQZtuRxzVecKY3apYCKvb7WpprAByCvP4zqKrEhZ0O1nj7ApraIRpjDZ9MjmxIqPFtDV9Enxt5QukoXgFWkbCNdcdwQdokp4BAcHzwdqWimy9A3IOa7JJyqWCfOfrLn1U8DAaReX9XBg/MnHO7qpgavZKxnW518Cd8D2i+4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLv+hzR2fqkT+PEMUZo6Nn+FbU5+phNm79gTlEFUZqo=;
 b=ZvtFNf8VKwjYEr32HjmE/eVkNjwGy/HtiFxPXvnldc0qRu/10htqmbISd5uPPNHwOhhMRx5qyaD0W2rnjqsOrzKk2PsJBGQPVfapDfQug5CeN4Nt3LlIlRPnZ11CtGx5zhGxSJALBnsnP+kTX0t6za4LUgQhgKa38+X3CsAn4iap6EROJfLGjr3aHHe8Y8XIMRkSi0sS50tI2Ww80uVNcFYbMAstqI4cKtYKxH+YkAQx3i8ZmIBJyCxLRt7EVNioy4P5oWtf0RQpaA+ft2iSjCvBYFu+4DynkqQ3uR0T+MilBzYjF7QGN1BJHxbKQeJ3bpdQenYihJ8KqKUi7ohhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLv+hzR2fqkT+PEMUZo6Nn+FbU5+phNm79gTlEFUZqo=;
 b=nGV8WsgCbDdFpyRW+p8EkpIOyTtotV/DxygN6UWb6IvhO4kny6gffb4rCvF/gxBKUyjUxQbFt/c1rm/a6GjJrQ9X47++qm1O7hx1jtbTlVSZn92XSjsJx97u+V4cjut1btEwqSs3RrW8wXK6a8Gum1xLkKgsqbc5Tk+q6hSFbyc=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CH2PR12MB4024.namprd12.prod.outlook.com (2603:10b6:610:2a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 23 Mar
 2022 21:26:16 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 21:26:16 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if device
 can wake from D3
Thread-Topic: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if
 device can wake from D3
Thread-Index: AQHYOIH4cjkXql1VyUKxzqcCT79LiazApEsAgAAAXoCADIi5gIAAUUqAgAAEXdA=
Date:   Wed, 23 Mar 2022 21:26:15 +0000
Message-ID: <BL1PR12MB5157F0111915C81F284762DAE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <83aee1d8-5700-d2bb-fae5-d952240c6fb8@amd.com>
 <20220323205201.GA1320371@bhelgaas>
In-Reply-To: <20220323205201.GA1320371@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-23T21:13:17Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5f51b90a-c5f7-4adc-a1e3-d310ab42dbd5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-23T21:26:14Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 81b59954-7f5a-457d-90ab-e4b431246251
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6c8d6b3-7f88-4c73-2085-08da0d13c37e
x-ms-traffictypediagnostic: CH2PR12MB4024:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4024F1D003402546DA8484F6E2189@CH2PR12MB4024.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nQGm21aYyzIrEQZeMcNmff458LfKSloymXHS7zo6/uDKNogN0OunuzWD+i2BdH3Nt4bq/QFlKxk/ePJaiSn5i7BvAYJjSywAmgNlgxuG+iccyEJaOTsqrldEGs/cNq8859QrXgDNkOHifI8uhJNAE5bpirjAAMhq2DkrjII0mFPIna9rvRK5+t3hpE9ywWARs5N1VjMrU3dTiu+Xo6t3+fxVrdZ95m7HXUAT7oXm1F0MueHIhmwKOlpGR976fsx1gKHGLT9qYdl6J562xBmtTfR3l8EeHuE+mV9AJdYxlLBnglNPAyFNuYUN5oPMCe4EeFq/QkdIUfL0ZzZGnRvo5SvVY71whvJAMG7Up1skT8+eZMrQm/jumfSZGlqqm2YO7pU4F/YuiFMPC9UTbfUY0KafUnq3OseyBNvz4UfxnLLAgET7d9BsP0Abq7pALXgN3Gis5JMXbpRW+yhemrFVdF9o/XhgiB7azYLvjdyitGzj56WKSUSyM8011HjhFSDozTmCaN+uzURaTFqsoGOZli6+6zkprY7O2PX0MXyeNygITUWa6ge4z0lADj7Q65QIkwexjcxgD4A3W+HyszEUAT6OjJsByfHNktAWFZII4zpCKLM6xjhxz+2N7pJuNjPBzaMS28Yic3XdHYHj+gZTuqUeJm1d9Jj+FiF5WJv7F8AsVqOiSb4twZjQNlHaeTi6Yrsl1NyjPyhcAx67WtR8rZ1Mnl941qzcQ8QJuusnoyoZFbkcsCk+NzIFbrSx7Dh0s8fO5xhMHSZxH5UP4swbzdjKlvzzUiJQHJUqrhTSsNRuhylE/dGY72ZXD0pa9LtfaGZ+05uuYG0VbxDr+6y+tAxiK318mbiEmhbPImzLGQQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(83380400001)(966005)(508600001)(53546011)(54906003)(45080400002)(9686003)(66556008)(26005)(8676002)(4326008)(66476007)(76116006)(66446008)(64756008)(66946007)(7696005)(6916009)(186003)(86362001)(55016003)(122000001)(71200400001)(52536014)(38100700002)(8936002)(38070700005)(6506007)(316002)(33656002)(2906002)(5660300002)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VN3InF999EV6NJAaXzDJt2MpTgDCs2S5O/HxFcHbHBEYIJlYon6FYQQm0fet?=
 =?us-ascii?Q?Us+K7MLJjADzTkuKzRYiCXbyQkoZIb9ygIj6/ae5d2jp7r+6WWVY7WU7woMa?=
 =?us-ascii?Q?HFmwM078RJgHLgxFEIYp97KUbCS8SDATIffLlbCzI+SOWQlpHeuk/R44TlWw?=
 =?us-ascii?Q?wqgEAkCRTQg9xGKxxeDJIp+qKbxyxUweFiB5M3pXK3aD9c19RI126rGnx6ji?=
 =?us-ascii?Q?+zb1l3zgn+iaiuW5hWajSOYU/QAayGcyBEsre3AlrmqAQUV3VwCcFajt1Ydl?=
 =?us-ascii?Q?8pW7IesiftNhlPp8d7NaxSi98p85N+x7i+gV1du0V2WfXt1eySYNOQJH5M0T?=
 =?us-ascii?Q?xKGkAc++WPFkdUDEN7qRN6lm5XjzoqPRcvW57Jzbgj/1YHrd+B579N6pJUY0?=
 =?us-ascii?Q?k6Rwh8PoTmTNhSCj352yHoF35V6O/WhRy4ixJKPyU+swCDPClopsiFyLem1S?=
 =?us-ascii?Q?u7AmzxazIGDTnsttkzcWg97WH5qTjKc7nDeqAAaajGrmJKaiVpWE+0J/L9Ra?=
 =?us-ascii?Q?SmrKiuWLizsdchkcegjn2OP67WLIPWb81/nqjeOB+iNvrh1u/R06Fsaezthv?=
 =?us-ascii?Q?y8HuHByVD2ueGWHU8AcbHfdSpbY6rhDHVl1bfiY20kQniSmPK+sDOoB5ZYis?=
 =?us-ascii?Q?SY5ReOjQcpvnhcIDrC1TNhyWHUI66jwA1yw+twW6mL0HeTCuBCoVPPIXc/mH?=
 =?us-ascii?Q?aFOzikrZmPzkIvPk9fNgcNAbwjZb/d3hfMzI0B494RPtWuteMOnplDHXhyZR?=
 =?us-ascii?Q?/pNkCGwDL+P+Z+sFPbNdVG+9Ljzfhw7Gmoye49q06GL/LuT9VDohSr9KJiw5?=
 =?us-ascii?Q?+8DJVGlMI7DZTAXinGmglC19UN8H3z+htWTb9TMlRmZ2rBa3Bb9im9isMZYK?=
 =?us-ascii?Q?GzuJOPI2+VPmuwTW2Z+2isbWBlAWt0P4w33+pDv2TNTgOvr4jSA3lnAznrwi?=
 =?us-ascii?Q?5RtdIfOAK6SPiEEWXh6rcBL452pbklo3J5tfoA3RIfExN+MUFX02AqoceRmP?=
 =?us-ascii?Q?2QOO4+1MYvbjp9lUKuKw09E4uDIBYX05tUaSZwI825czDKLo/C7bUjOBc0xh?=
 =?us-ascii?Q?2w3lLfd1Szsz03CqNWJtzsktk4uoxlll01CXfE7dtEamcHmDXZiWRooxEu7V?=
 =?us-ascii?Q?9PXLa8lL8UhEwtmwy/YmlO1hIgP66bybsyiiGZNDl9IatAASz/V9jql75Arm?=
 =?us-ascii?Q?NO9Y5KpU12t1UIVgh1MH0qbiIpverCKdizYhrFkncTl6J2Bnta637adGyRBu?=
 =?us-ascii?Q?2dPjiQ/ImgYHQnWGi85h6W7crawAlBLJ3FFRUfiAspuzFhrRk+8UXjuTXYiI?=
 =?us-ascii?Q?88hpPnyOR7JGq8SyReOW4I7yIS+PeELOsAmFSWBx4KN8Qg1JXKPWvMKISjJi?=
 =?us-ascii?Q?0QowwBpLP2xYmIXJ38IPrCLBrSwg3JlHA+M87n+qDPR8wru1dGzQ1p/ulXwZ?=
 =?us-ascii?Q?10JK1nYsiAk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c8d6b3-7f88-4c73-2085-08da0d13c37e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 21:26:16.0303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBmFFTZizPvGdw8bd9MYtfuzqPHA76cQJP21HWS5qOdTNKOGcrqMkkiFl+hIUHZx8piuOdX3DkdZi4BDZ2QTrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]

>=20
> On Wed, Mar 23, 2022 at 11:01:05AM -0500, Mario Limonciello wrote:
> > On 3/15/22 11:36, Rafael J. Wysocki wrote:
> > > On Tue, Mar 15, 2022 at 5:35 PM Rafael J. Wysocki <rafael@kernel.org>
> wrote:
> > > >
> > > > On Tue, Mar 15, 2022 at 4:33 PM Mario Limonciello
> > > > <mario.limonciello@amd.com> wrote:
> > > > >
> > > > > According to the Microsoft spec the _DSD `HotPlugSupportInD3` is
> > > > > indicates the ability for a bridge to be able to wakeup from D3:
> > > > >
> > > > >    This ACPI object [HotPlugSupportInD3] enables the operating sy=
stem
> > > > >    to identify and power manage PCIe Root Ports that are capable =
of
> > > > >    handling hot plug events while in D3 state.
> > > > >
> > > > > This however is static information in the ACPI table at BIOS comp=
ilation
> > > > > time and on some platforms it's possible to configure the firmwar=
e at
> boot
> > > > > up such that _S0W returns "0" indicating the inability to wake up=
 the
> > > > > device from D3 as explained in the ACPI specification:
> > > > >
> > > > >    7.3.20 _S0W (S0 Device Wake State)
> > > > >
> > > > >    This object evaluates to an integer that conveys to OSPM the d=
eepest
> > > > >    D-state supported by this device in the S0 system sleeping sta=
te
> > > > >    where the device can wake itself.
> > > > >
> > > > > This mismatch may lead to being unable to enumerate devices behin=
d the
> > > > > hotplug bridge when a device is plugged in. To remedy these situa=
tions
> > > > > that `HotPlugSupportInD3` is specified by _S0W returns 0, explici=
tly
> > > > > check that the ACPI companion has returned _S0W greater than or e=
qual
> > > > > to 3 and the device has a GPE allowing the device to generate wak=
eup
> > > > > signals handled by the platform in `acpi_pci_bridge_d3`.
> > > > >
> > > > > Windows 10 and Windows 11 both will prevent the bridge from going=
 in
> D3
> > > > > when the firmware is configured this way and this changes aligns =
the
> > > > > handling of the situation to be the same.
> > > > >
> > > > > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fuefi.=
org
> %2Fhtmlspecs%2FACPI_Spec_6_4_html%2F07_Power_and_Performance_Mgmt
> %2Fdevice-power-management-objects.html%3Fhighlight%3Ds0w%23s0w-s0-
> device-wake-
> state&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7C1f96c7aa37a
> c47640d6208da0d0efd67%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637836655281536690%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata
> =3DCw1OTYiX9BD3gh8eN3Zyz6%2FK8YFgqbn6bgi9%2FjNsnrM%3D&amp;reserved
> =3D0
> > > > > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs.=
mi
> crosoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-for-pcie-
> root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-
> d3&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7C1f96c7aa37ac4
> 7640d6208da0d0efd67%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%
> 7C637836655281536690%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D
> UkB5lmz1QBUzWVM6%2BuNzJsleP%2Fi%2BDCJJuSgINiNbymo%3D&amp;reserv
> ed=3D0
> > > > > Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hot=
plug
> ports")
> > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > >
> > > > No more comments from me:
> > > >
> > > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Or please let me know if I should pick it up.
> >
> > Bjorn,
> >
> > Friendly reminder on this one.
>=20
> Thanks; we're in the middle of the merge window now, so I'll wait till
> that's over unless this is an emergency.

Actually it's a pretty important problem.  We waffled on the nuts and
bolts of this commit during the 5.17 RC's, but I didn't think we would
make it out to the merge window before it got picked.  I guess I should
have spoke up on the urgency earlier.

>=20
> IIUC the bug this fixes is that "when a bridge is in D3cold, we don't
> notice when a device is hot-added below it," right?  So we need to
> avoid putting the bridge in D3cold?

When the ASL has been configured this way (to return 0 for _S0W) the
lower level hardware implementation will lead to hotplugged devices
not being detected.
Without this commit the hardware will expect to be in D0, but the kernel
will select D3hot.  So yes; the outcome is that hotplugged PCIe devices
don't work.

>=20
> Is there a typical scenario where this bites users?  I don't think we
> ever saw an actual problem report?

This is the common way that these systems are being shipped.  I have
plenty of private reports related to this, but nothing public to link to.

FYI: the earlier version of this was:
https://patchwork.kernel.org/project/linux-usb/patch/1646658319-59532-1-git=
-send-email-Sanju.Mehta@amd.com/
This is basically to intentionally pull the device out of D3hot when a
tunnel is created.

>=20
> > > > > ---
> > > > > changes from v3->v4:
> > > > >   * rework comment
> > > > >   * only evaluate _S0W if necessary
> > > > >   * drop static function with only one caller
> > > > >
> > > > >   drivers/pci/pci-acpi.c | 17 ++++++++++++++++-
> > > > >   1 file changed, 16 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > > > index a42dbf448860..e535dab2c888 100644
> > > > > --- a/drivers/pci/pci-acpi.c
> > > > > +++ b/drivers/pci/pci-acpi.c
> > > > > @@ -977,6 +977,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> > > > >          const union acpi_object *obj;
> > > > >          struct acpi_device *adev;
> > > > >          struct pci_dev *rpdev;
> > > > > +       unsigned long long ret;
> > > > >
> > > > >          if (acpi_pci_disabled || !dev->is_hotplug_bridge)
> > > > >                  return false;
> > > > > @@ -1003,7 +1004,21 @@ bool acpi_pci_bridge_d3(struct pci_dev *de=
v)
> > > > >                                     ACPI_TYPE_INTEGER, &obj) < 0)
> > > > >                  return false;
> > > > >
> > > > > -       return obj->integer.value =3D=3D 1;
> > > > > +       if (!obj->integer.value)
> > > > > +               return false;
> > > > > +
> > > > > +       /*
> > > > > +        * If 'HotPlugSupportInD3' is set, but wakeup is not actu=
ally
> supported,
> > > > > +        * the former cannot be trusted anyway, so validate it by=
 verifying
> the
> > > > > +        * latter.
> > > > > +        */
> > > > > +       if (!adev->wakeup.flags.valid)
> > > > > +               return false;
> > > > > +
> > > > > +       if (ACPI_FAILURE(acpi_evaluate_integer(adev->handle, "_S0=
W",
> NULL, &ret)))
> > > > > +               return false;
> > > > > +
> > > > > +       return ret >=3D ACPI_STATE_D3_HOT;
> > > > >   }
> > > > >
> > > > >   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t s=
tate)
> > > > > --
> > > > > 2.34.1
> > > > >
> >
