Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB384E5AE8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 22:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbiCWVww (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 17:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbiCWVwv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 17:52:51 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE36BDDC;
        Wed, 23 Mar 2022 14:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpAawEaAk9PuwR7LynRgsYnL+MbXEc4nvwhQz2VL47Dcal3co8HMv2aKZNU9GEgdkJ33J4gGHsWzYhpx7nwJ2RQZ7wfJVoHyPxFNlIn8UPPdx9NriGP3XIMfD1F8v0E+QRGEMpFm3DHu+wxADq47k5SLDtmX9yiCMuJBZuY1MbxhPHzV5Ubg+m/MrrgHmAEBUc/AhrkQBHkYBDPG3LJ69vgkkMAai/h6AfKof2712yR05Lqo0iLSSl+IaIlDLLvAk99dBoh9a2cCDjF6UN+1LAulKrzi+h5YwHIrdkPhdxwpLwU9M6ndir906h2h+LHQmcrv+3hfDUUjgN9EjAvLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKVceeBM7duFp9iCzKj9Ixl2nmhz5rYZAVVlCxDLo8U=;
 b=S/ettpRV5WcfgEa3Z4cuckxvzu6ro+XoaqvUEAV/gJU99eHqc3owHH2U1iuF22PiKAdER633M8Nrboiom2akxDhVjVLMm93LjxwqHWLSqvrF+IrrX8n9mrRUm1uMN9HxgY9Ox+WnL8L3zbwFCCGRe0qkxlGFbG8bWI8meOKAofZX/j/nc4nI4JHFAnDIM2b0yEdQiy961InUi8OneD7TEqCx3wfXzPoSNyzmdqQR49mxTfMq+qw0kxSyYB8St/lvVrU/4v03ajiJeDuT1zab+jidLF6LhxhaYRdSoYrLrdvPOU2GjujcsMmEy1F6D4e1es50E2i7dtoEiBXZIdub2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKVceeBM7duFp9iCzKj9Ixl2nmhz5rYZAVVlCxDLo8U=;
 b=nn+9kHemOt1bkHL3QDW35I9iKNrhjPDer6spMC0VLEQZEhJIRI1IYndxFjTyCkjPl2gEZ0Jv+9j46Q9nOgiej4MRGL1s8Z6PRCMfXJGNQO/6ToGE0E0KBI95cz/3SUST/874NQLU0lvA5hIohYyBHH628Ed4k4qwgEVkj+/MyHM=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 21:51:18 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 21:51:18 +0000
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
Thread-Index: AQHYOIH4cjkXql1VyUKxzqcCT79LiazApEsAgAAAXoCADIi5gIAAUUqAgAAEXdCAAAnIgIAAAD8g
Date:   Wed, 23 Mar 2022 21:51:18 +0000
Message-ID: <BL1PR12MB51575C7E6979A60E2637CC82E2189@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <BL1PR12MB5157F0111915C81F284762DAE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
 <20220323214239.GA1373960@bhelgaas>
In-Reply-To: <20220323214239.GA1373960@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-23T21:43:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=89d0f93e-ccc2-4607-829b-67810c99a68f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-23T21:51:16Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: f006c90a-f5e0-4ec1-8282-c8b683b840aa
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c3ebb5d-7036-4180-0746-08da0d1742e2
x-ms-traffictypediagnostic: DM6PR12MB4975:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4975BD4ADEB29A1BB2D38300E2189@DM6PR12MB4975.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+3MnXhrz9qyJ18xwMvXPeMVXW5fLbmK6bJXpRNjTvpVmDMgL+KaK7uQYeoE/wtHUDVBpxMvnIcpnEOtlrXgzEMog+GAbaN1Kzn9HhYtJXp5QMc926Sji7WVBY7z8q0DieABeYDfx4yrs+WTJxtnxROVt3RSZ8XXyTTfB+Vig+ULIn3EG5A0U5AuAt4njDJG+57NV7QfGrcwG7Q/4NnC7A+lWOxbYboNwppw1zlwz843H8nXhmC2ZT0nrMyp/nE2kP7KMbfrkLCZWmodAH3jLtk4X5M2aIXwetYk4sSfiXNURzSjbVHwN8WpgYydBgBOvERwUn34khyJ7HIN14WPZiCfHy+8nr+HFT7QphR7vYqFpJNTONOkhzekiCZW24ifN2yCamMcH+vMWlYDGURqCK7+sn7tGmjsQ5FNV7+oTcGgQYgHhgYX6eOnXIYkV6R8wnOMbdwVr0g+3f4hedZcFVmEgzGf+807xAcJN5M+9agygC9FUImo2yZG8h2UZw+IQDljGTbB2+JobqT09G1hdg4uZR+Ud0P1Wj679sMnXjHkXnz9yIKV8o+Osn9W0LIfjMJDN3Vw2PYY7v4ARcBkTEMBwL4kqeGV4Z7ARqFOJIuRRdfbtjfXBIw8O4xRcF41z/oayRETwYAWE1HNEH+I/Yt2/dhRcifqCa+Dcf08AaK0ic0h2Pmu0wGGyyoumhAs/TvnhdzOEQSOHV8soKFrNHVeNcxVoU3kCOJmRz/7UoliQV+Iqxjfi8/JtydKQYI+YtCITHnjDP4kWrTy/SDup3KP9EK8rbxWho0mQB7WX2q/taIM40j7Xv2TPL3g8qKnLJbHAl+a/tgnlNSr87VuYWcjLZwkMZ5a9SR4gNA2hJg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(55016003)(38070700005)(45080400002)(7696005)(6506007)(8936002)(86362001)(53546011)(9686003)(2906002)(5660300002)(52536014)(122000001)(966005)(4326008)(33656002)(316002)(8676002)(71200400001)(66556008)(83380400001)(66946007)(186003)(38100700002)(76116006)(508600001)(6916009)(54906003)(64756008)(26005)(66446008)(66476007)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lZnjKanQu+G/C/Q8L17jKxY+h1qcw/2V3bI7ZEdoc8rTG20j1qxuW5QwReDf?=
 =?us-ascii?Q?joOwrAk2LkcmMRlGjY3B0cG784SeEDLwYuyBeJMZV8V3xRd8A4yEy7KyH511?=
 =?us-ascii?Q?OKfUYx3C7U1Ctk1A/2rzNe4PDsoL5crdR11oe+kPDh3u50bnIp4Fvh1F8aE0?=
 =?us-ascii?Q?FGdHgPfCWPyfCjRYIH3DBNlCeQX+0y4yKdM0mQllaZIL8bCP8/SIpO+Cs4Ns?=
 =?us-ascii?Q?sA1Oo/x3vlswnrlVfPhPUoXbl9dwjI6JpUHXzSwNLREWooDMATtcazc8VUxe?=
 =?us-ascii?Q?skjh7qYZBxEL7TJoS0+u97zypInoXHP28qF5Gz4kUb4iQXnei3uEZB2kD0fV?=
 =?us-ascii?Q?7kwERBpp2sxdSMYAwg0TZdUu4Iwhg0jhsVWhT/S8sfaGybG5kmj1LPEYn5Qq?=
 =?us-ascii?Q?GNR9rS+LEvUEGS8pHhQzAB42nj8IVJbom6kIach1ad28NZMLC7AKd3084+4n?=
 =?us-ascii?Q?+wZs/58BO30P04tHX+VmsX45Ejp+ivfBHJ8HiInrYif1rW6/CUtnm9hqQbqH?=
 =?us-ascii?Q?LU6gY3wYXGeyOhxZJsVCNpzGJW0U0E+vIk+7P8shsllhDyK6UYK9sIFdv3rh?=
 =?us-ascii?Q?p/qVRh62XcqOrKoANsHPLqVrmb1vq/HCi+sgox4DysXdUgWZ4al2rVzPuplA?=
 =?us-ascii?Q?sUNaXLKt6oIxJA45lcd1jB6Wo5KiIQCWSxbp/Yi6C5pQV72m8Fe10z/nW7dS?=
 =?us-ascii?Q?6I8Q/TFGZN4aYY9hglqEqrLrbNag/cPD5bwhv4rwM3MAZgqV5oQfeKTmoktK?=
 =?us-ascii?Q?+4BPo+VbTYP4TThk4mkRffN7c30Me2tyloQGoUXU+mRBFW1AF0TwMZuaPvaR?=
 =?us-ascii?Q?ly4E5pFO+FR+WUVRiX+BvLqnxzjmHnSxwp7ZBJqsTB3lC6z4D7Ungy9dCZcq?=
 =?us-ascii?Q?PAmtf2sZ6iJYdr7R+Xh/0FwZKjtXahGYhVecqPDWKgxnoRzu2jnwD5AEcIty?=
 =?us-ascii?Q?i2/H0uMpXY2F3ry91Ke2DaiStA0/FrFaoNUYD6ZlQ4mbD8qhsB8VHe9nw0Uh?=
 =?us-ascii?Q?wxyOVLGN4GvHby5D+qM8B+jpJduu4qa3C+xPoidoOEmnUSHWIMH16SzZqeze?=
 =?us-ascii?Q?gn9LeuiFBP93NXv2BRwX9cD48EFR1CNmPKu2NBfSF7Q/2EGGjJEH1pr7DVPI?=
 =?us-ascii?Q?7yQH/4xz6MpjcLyJ9zedfgmyh9CIDaRxm4JoDMtpfarGRuWTn+wfR0CVAZCM?=
 =?us-ascii?Q?4Z8u+3SKNHLgeT+sSVguaQ7L+oMy1AHnpFvbgY6UgcGebzIMF8c9iTLcspif?=
 =?us-ascii?Q?AZWrO7urEsfZ3AzUZsT8dOgSHgx/idhaGreYTTeuU/wvHRIoFn++vjyzNvvv?=
 =?us-ascii?Q?fBPoU7epXqQh3kxaRRxBSIeaaOiIG3cK49lkfBsq+KNiFn7AqlH6bJraMMh6?=
 =?us-ascii?Q?zV5CBEZLJ/ethUKKjPeMmp7vtcwBeNPsdYc+vzqWhFbXDdWeQ4zLjN9hwDqa?=
 =?us-ascii?Q?D8gEfV410Iw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3ebb5d-7036-4180-0746-08da0d1742e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 21:51:18.2614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCVlqSTyRxv75J1XuXXtPs1gsASQBHAyRZX7BrC3lC67W0nXS9xWwRduE1qgFGQvuPsF2/wJDzBx7JhaYmXkSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975
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



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, March 23, 2022 16:43
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; open list:PCI SUBSYSTEM <linux-
> pci@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>; Mehta, Sanju
> <Sanju.Mehta@amd.com>; Rafael J. Wysocki <rafael@kernel.org>
> Subject: Re: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if d=
evice
> can wake from D3
>=20
> On Wed, Mar 23, 2022 at 09:26:15PM +0000, Limonciello, Mario wrote:
> > [Public]
> >
> > >
> > > On Wed, Mar 23, 2022 at 11:01:05AM -0500, Mario Limonciello wrote:
> > > > On 3/15/22 11:36, Rafael J. Wysocki wrote:
> > > > > On Tue, Mar 15, 2022 at 5:35 PM Rafael J. Wysocki <rafael@kernel.=
org>
> > > wrote:
> > > > > >
> > > > > > On Tue, Mar 15, 2022 at 4:33 PM Mario Limonciello
> > > > > > <mario.limonciello@amd.com> wrote:
> > > > > > >
> > > > > > > According to the Microsoft spec the _DSD `HotPlugSupportInD3`=
 is
> > > > > > > indicates the ability for a bridge to be able to wakeup from =
D3:
> > > > > > >
> > > > > > >    This ACPI object [HotPlugSupportInD3] enables the operatin=
g
> system
> > > > > > >    to identify and power manage PCIe Root Ports that are capa=
ble of
> > > > > > >    handling hot plug events while in D3 state.
> > > > > > >
> > > > > > > This however is static information in the ACPI table at BIOS
> compilation
> > > > > > > time and on some platforms it's possible to configure the fir=
mware at
> > > boot
> > > > > > > up such that _S0W returns "0" indicating the inability to wak=
e up the
> > > > > > > device from D3 as explained in the ACPI specification:
> > > > > > >
> > > > > > >    7.3.20 _S0W (S0 Device Wake State)
> > > > > > >
> > > > > > >    This object evaluates to an integer that conveys to OSPM t=
he
> deepest
> > > > > > >    D-state supported by this device in the S0 system sleeping=
 state
> > > > > > >    where the device can wake itself.
> > > > > > >
> > > > > > > This mismatch may lead to being unable to enumerate devices b=
ehind
> the
> > > > > > > hotplug bridge when a device is plugged in. To remedy these
> situations
> > > > > > > that `HotPlugSupportInD3` is specified by _S0W returns 0, exp=
licitly
> > > > > > > check that the ACPI companion has returned _S0W greater than =
or
> equal
> > > > > > > to 3 and the device has a GPE allowing the device to generate=
 wakeup
> > > > > > > signals handled by the platform in `acpi_pci_bridge_d3`.
> > > > > > >
> > > > > > > Windows 10 and Windows 11 both will prevent the bridge from g=
oing
> in
> > > D3
> > > > > > > when the firmware is configured this way and this changes ali=
gns the
> > > > > > > handling of the situation to be the same.
> > > > > > >
> > > > > > > Link:
> > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fuefi.=
org
> %2F&amp;data=3D04%7C01%7CMario.Limonciello%40amd.com%7C095e9cb1cb3
> 34458a08d08da0d1610bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637836685684066439%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata
> =3DaAj91EajV77J7GjWEGGhAYLAb9Al2TMsH1baasdVdyI%3D&amp;reserved=3D0
> > >
> %2Fhtmlspecs%2FACPI_Spec_6_4_html%2F07_Power_and_Performance_Mgmt
> > > %2Fdevice-power-management-objects.html%3Fhighlight%3Ds0w%23s0w-
> s0-
> > > device-wake-
> > >
> state&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7C1f96c7aa37a
> > >
> c47640d6208da0d0efd67%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> > >
> %7C637836655281536690%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> > >
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata
> > >
> =3DCw1OTYiX9BD3gh8eN3Zyz6%2FK8YFgqbn6bgi9%2FjNsnrM%3D&amp;reserved
> > > =3D0
> > > > > > > Link:
> > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs.=
mi
> %2F&amp;data=3D04%7C01%7CMario.Limonciello%40amd.com%7C095e9cb1cb3
> 34458a08d08da0d1610bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637836685684066439%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata
> =3Dv8YYoxTCp1drb7ZxgbDkrgA2Nc3TxbENLBfPxbo1CTI%3D&amp;reserved=3D0
> > > crosoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-for-
> pcie-
> > > root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-
> > >
> d3&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7C1f96c7aa37ac4
> > >
> 7640d6208da0d0efd67%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%
> > >
> 7C637836655281536690%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> > >
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D
> > >
> UkB5lmz1QBUzWVM6%2BuNzJsleP%2Fi%2BDCJJuSgINiNbymo%3D&amp;reserv
> > > ed=3D0
> > > > > > > Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe
> hotplug
> > > ports")
> > > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > >
> > > > > > No more comments from me:
> > > > > >
> > > > > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Or please let me know if I should pick it up.
> > > >
> > > > Bjorn,
> > > >
> > > > Friendly reminder on this one.
> > >
> > > Thanks; we're in the middle of the merge window now, so I'll wait til=
l
> > > that's over unless this is an emergency.
> >
> > Actually it's a pretty important problem.  We waffled on the nuts and
> > bolts of this commit during the 5.17 RC's, but I didn't think we would
> > make it out to the merge window before it got picked.  I guess I should
> > have spoke up on the urgency earlier.
> >
> > > IIUC the bug this fixes is that "when a bridge is in D3cold, we don't
> > > notice when a device is hot-added below it," right?  So we need to
> > > avoid putting the bridge in D3cold?
> >
> > When the ASL has been configured this way (to return 0 for _S0W) the
> > lower level hardware implementation will lead to hotplugged devices
> > not being detected.
> > Without this commit the hardware will expect to be in D0, but the kerne=
l
> > will select D3hot.  So yes; the outcome is that hotplugged PCIe devices
> > don't work.
> >
> > > Is there a typical scenario where this bites users?  I don't think we
> > > ever saw an actual problem report?
> >
> > This is the common way that these systems are being shipped.  I have
> > plenty of private reports related to this, but nothing public to link t=
o.
>=20
> I still have no clue how many people this affects, what kernel
> versions, etc.  If there are no public reports, it suggests that it
> doesn't affect distro kernels or production machines yet.
>=20
> Can we at least list some common scenarios?  E.g., it affects kernels
> after commit X, or it affects machines with CPUs newer than Y, or it
> affects a certain kind of tunneling, etc?  Distros need this
> information so they can figure whether and how far to backport things
> like this.

It's going to affect any retail machine with the SOC we refer to in the ker=
nel
as "Yellow Carp".  This is one of the first non-Intel USB4 hosts and will b=
e
using the USB4 SW CM in the kernel.

Without this change, effectively PCIe tunneling will not work when any down=
stream
PCIe device is hotplugged.
In the right circumstances it might work if it's coldbooted (if the paths s=
elected
by the pre-boot firmware connection manager are identical to that selected
by SW CM).

Yellow carp isn't supported in the kernel until 5.14, so should this be bac=
kported
it shouldn't need to go any further than 5.14.  (Realistically though no di=
stro should be on
5.14, they should have gone to the 5.15 LTS). =20

Should it behave well baking in mainline, I would also later suggest to bri=
ng it back to
5.15.y and later as well for distros to pickup.

>=20
> > FYI: the earlier version of this was:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
w
> ork.kernel.org%2Fproject%2Flinux-usb%2Fpatch%2F1646658319-59532-1-git-
> send-email-
> Sanju.Mehta%40amd.com%2F&amp;data=3D04%7C01%7CMario.Limonciello%40a
> md.com%7C095e9cb1cb334458a08d08da0d1610bf%7C3dd8961fe4884e608e11
> a82d994e183d%7C0%7C0%7C637836685684066439%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3DtMSmfEl2%2FcvcFwNr7tg8QBi3s6HA8ZBgg5rCa7DZD
> Hg%3D&amp;reserved=3D0
> > This is basically to intentionally pull the device out of D3hot when a
> > tunnel is created.
