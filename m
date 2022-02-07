Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27BE4AC46B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiBGPyI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 10:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384914AbiBGPwR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 10:52:17 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E25C0401C1;
        Mon,  7 Feb 2022 07:52:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpjzhLGNHGvWnhmEjdC67RrqXjVebmVBcBxys/eibDZcqCriciu+PYnXk15L6luOUcw8SkT1GF63/eCE5dQ9UEYB8BOsb28gQQ+9Qfupo55UD11AMeBv3V176/KSibRA60RNpuLasCWIiUV6bieLMaVUXpV6ww6djpSrlgc6XBerI9VZa9CtIEoR+vK6vhulkkyTUWsnRPf1Dlm9K0SZiuX1CGXRrxFSw+b7rk4ZurmYe2hKISIT1DiyRQtY29tiphw1w+QYtwyvimpqPKLMnH/wULfDILxGRts3Keb+Jebka8fArWCEwP/t17ZE+zShaf0Y6AFNj8nfxSbEO3yTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiLH8UJgeiaHygvAj5YeNrWacWSXBqicA5Uc1AkhdvY=;
 b=JNYOEcSMqR4bkANIMKlu36Zl7yMid+zLa19DXuJHCniY7n89GQmhUWkxhFkWx1PMqqcYecY/3DFOMgPBpW30e12kYvqfVKSe6iGv4mdHmAHHtk1S7m6xTRcEiFU/azoabBIQZQ6DHHh0WOFCylBjMYZGRMAaaJMmm21pIYSCqBZ0Ln+XFv3KmhPMJpvVI5unkHO3CRzkE8ic9/TbPbL9/ue+qrn5OPkerdRJtbw9N7GbJHFALrFbgIduQNsB2QOMy9Hi2VNJoJGUfi76r7fWeA41KbdKKfMn28ueTlzv2PntTqdaIQxcd3YMrXWSEDM4T1MAZD2tgO1IuxKJwHXT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiLH8UJgeiaHygvAj5YeNrWacWSXBqicA5Uc1AkhdvY=;
 b=wz9WqnJT0bTTyr/Hn+dKxtWpLZpc9dr3cEX6dLZdOSBxquKVOlOLSR3pZVFLPN38isF5FZUOYfhxKcyxpIMwiL1z/nMy9HYnP2XsHbGd9jMOkSEmjoYcLRDqzal4GDNET3mfe9M3qZUeeL3Njg36wMI0Rz+IDM9fwDjVfMf2hy0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 15:52:14 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 15:52:13 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: RE: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
Thread-Topic: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
Thread-Index: AQHYGfUZ8uN1dYeam0W687TAa8QHVqyHp7CAgACJyACAAA36gIAAATnA
Date:   Mon, 7 Feb 2022 15:52:13 +0000
Message-ID: <BL1PR12MB51442184B407A747E4C487F1F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220204182820.130339-1-mario.limonciello@amd.com>
 <YgC/NQFN7yOffKv3@lahna>
 <BL1PR12MB5144B3A3F70AE921721E1397F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <YgE+g9JOJE6foThi@lahna>
In-Reply-To: <YgE+g9JOJE6foThi@lahna>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-07T15:49:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d9f74288-298f-42ec-a454-fb109a053e72;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-07T15:52:10Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 492b7936-e60f-40a0-957b-eb034eb183a1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67bd4555-0d74-4ab5-8de8-08d9ea51cf3a
x-ms-traffictypediagnostic: SA0PR12MB4431:EE_
x-microsoft-antispam-prvs: <SA0PR12MB44319D89B5C9C64E67584D6DF72C9@SA0PR12MB4431.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywUWWTtpBc5Um8TsmDMSclF2wpNPrg6nLJ/7cBcFT0yvgmlGDAhaLq3LMR22b8d74so9VbZqILngDV3yzeFWRLunxGC8Q6ux7DKavRxtze569tTMqakzfJ4wOBwNc0jI0x/iLrP0vFZJDSOF7opAmbQYly4Tl8V973/cGgd8Fb5xB2GW/fYk8e/gpofi2iP2rK/2L1ZvglrQUNKRLlg58H44zF58ItQ3ZVVgwrjYG9xFdLXwkL4vOTU879eTlpylvMrWTxtjS3oZ2adKrCAYsWgd6hkHOyFJi4b+JRoKXGclcSfufzWGqOP1wQdvpn/ohJuOgObgaRhsMVaempWH6JtaTeSKfnZf301vXwNlRDT2n4mig/E5kiKX01DO25I2fS3v4uNuy0zPlAlFaYrxBtLoh+LlcajsQb3MZ3zuo8kt0Tb9gkCxbRBLOW1uFFsoSNOx6BVcLmLpkz4OYKXpd4TdbrHpul32jKMRGICZ9hbHgP3LkvhjXPg+hIchEo1u49fYTUaIH3Z7ye4k6/enonqOzSzLXkVs1rI10iNhPoRnFSKBXkqEE9zWCcwrrvUeY98JzXTxwGuRnYIJwHGxQ27P2zqMnn5nPLporVItJKaGOZ4QX4otBnCFefJ5wxP2Gvc4+bf01uqN+TkBQYhYaJ/WPsRBLev3fr2n0mGM4iYQyxti8uhm3sWHKak6LR2eI7svFXFcDe/kMovtddwmMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(83380400001)(122000001)(2906002)(5660300002)(38100700002)(38070700005)(4326008)(55016003)(66476007)(66556008)(8676002)(66446008)(64756008)(66946007)(8936002)(186003)(76116006)(316002)(33656002)(26005)(6916009)(54906003)(9686003)(71200400001)(53546011)(508600001)(86362001)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b/0302DCotv6fbO8lDAH2OUiGp+onYIowO3JUQor4kfCbY8wP9TWRSB5+PvA?=
 =?us-ascii?Q?bkZuEL2+AXx9Fe/idw6VMJMf18jMExM5OM7ixfzkTiZ+dNxC3fCT0Yv63AqU?=
 =?us-ascii?Q?a1ZvpnqZRY2zTGTKq2jENqEOnr4U7hFs8CY7Hj49bGDrIbGYA6csz/Ri9/rA?=
 =?us-ascii?Q?KyaT8XknG7H3X3KwlydUbSSEx72bpa8TXoxVCF2qy6knnb9RNfCBYy5gT3RP?=
 =?us-ascii?Q?PkFom4NITwzhakVQudI9r1BkWlPg/RH44rzOZsxhvNBnIPfopkkagVO3fCw6?=
 =?us-ascii?Q?RPZtt86OgIthODw3JqIzJMYFz0rhQQUiQiEkx+LNuL3ccOP8YRIenyfKWrQJ?=
 =?us-ascii?Q?rOjFJp/JaJYGlXamNRJtdD7wHcxu9EN4v+ZmjaDfETFkmsZr+FnQiVco3haN?=
 =?us-ascii?Q?fQd79sFHeB1C++nSQI+/XTFrsT7ggDE651PSgLtytSZl0q1Sg9wDobEcxzL6?=
 =?us-ascii?Q?Ug8cE0nOcYZo+97a5v7+CSYuO+69Id5Gzs1odHXgXpJFoQwDJhMK8GUwAcHR?=
 =?us-ascii?Q?OPqjLg7dHpnLA2b6clAWzWyhsejYTFerjqpUndf8ljG5286yQKbIjs12ZMdc?=
 =?us-ascii?Q?nelip0KhQOhZqTeZZs/CMk3uKMFbCqZ+octLJ/l1prke7tWYXOMZI1J4Mj2n?=
 =?us-ascii?Q?mC8CjvAu3skCRM2d6XvkYBC/ysnjSKIxhYztQ1dvfJrNUhfLW8bKy2Wr07f/?=
 =?us-ascii?Q?9wFd16xTaG+cziIIAt/WDKcgWxNtPvJBVkWrXUgKWXsX0A6z33RLVNH0BG/m?=
 =?us-ascii?Q?LY9AyMDA7tj7fgyE+NGV1zFgQ7rc3s4+PcfcKcbWH/elnz74iVEHRClzza2S?=
 =?us-ascii?Q?oqzxdv8Oq+b6gkf9b8jJgnUkSvY3jTuyQ30MlHG0gEzin7K1osH5PzJWbqNn?=
 =?us-ascii?Q?bYq69J5Wy0CXe7zgapJeDJcmjR72MY6Tak3bc0ogn96QHX73hpJcBw0l+WW4?=
 =?us-ascii?Q?abRofFVpnSSbxTUe3Qsq8Ef0/9COWvSQuqRzIin9k0gl/3dvH2ZzHcIll/pi?=
 =?us-ascii?Q?Yppow0k7DVd9fICJ91+FwEAQ6CJgqHIWmBnYZW6wW2M3xPJIYwO3GfN8XaMq?=
 =?us-ascii?Q?aeaSVJXMEwlX30pm6WbjOOaiMNRjJaTqEHlSnJulni41BZB21pDCVsKhVUDF?=
 =?us-ascii?Q?lTB5hVte9Lv7awnKypEKTYu5mEZvYz6E2diIWjg77P5A5cPQFW3o/2fYrBuj?=
 =?us-ascii?Q?fEByJmVcCPOccIp4ANCIC5qZi027tkYErIHSbYbr+L3DHP9+YMWFpb+2kPDE?=
 =?us-ascii?Q?zw4Swa29FH35jbKImyN72myYBZoT2IUmIMV6yx25p5fEQb96XydJpOMS9Ggi?=
 =?us-ascii?Q?gn/shOS4Qn0Tmq7S8C8Y6Sf7n6ZgUm3vZZL1vMqS+ydBdjE8KjoUuBaL6xCu?=
 =?us-ascii?Q?PGV/KIvQs0X2cp6gXb/V6/friWX9h6l8mTZvEbOd3hY+oMPBA8xSxrnm1Mub?=
 =?us-ascii?Q?coTXfXZDgUBt3RU26798u+aNfB3LMgR322f2l5sVJR8weFNz+DgL8DLfZ8Wd?=
 =?us-ascii?Q?al4+NhIPHGMIwLvRIi4qUqrwIHcRlSKkqTzQLFmFIiPPLsfqhBpcmwmRNmGu?=
 =?us-ascii?Q?cZLGYlbOo5R1Bp8AqQw5BrTix1NYLRdQan5m10Zhjy5qb+bFj/ggSeHZ8lpg?=
 =?us-ascii?Q?iZr4qdaaPieLURGJMPmOGnE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bd4555-0d74-4ab5-8de8-08d9ea51cf3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 15:52:13.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRaz25cv2YJ6dRt7M4dH+LSXhuL4QqIN8oUQxHbitppzftvF7QStG8rbm/Rb/2KFdQxshwE/NkIFhEaEDQGKMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Monday, February 7, 2022 10:45 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Bjorn Helgaas
> <bhelgaas@google.com>; Andreas Noever <andreas.noever@gmail.com>;
> open list:PCI SUBSYSTEM <linux-pci@vger.kernel.org>; open
> list:THUNDERBOLT DRIVER <linux-usb@vger.kernel.org>; Michael Jamet
> <michael.jamet@intel.com>; Yehezkel Bernat <YehezkelShB@gmail.com>
> Subject: Re: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
>=20
> Hi,
>=20
> On Mon, Feb 07, 2022 at 03:00:19PM +0000, Deucher, Alexander wrote:
> > [Public]
> >
> > > -----Original Message-----
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Sent: Monday, February 7, 2022 1:42 AM
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>; Andreas Noever
> > > <andreas.noever@gmail.com>; open list:PCI SUBSYSTEM <linux-
> > > pci@vger.kernel.org>; open list:THUNDERBOLT DRIVER <linux-
> > > usb@vger.kernel.org>; Michael Jamet <michael.jamet@intel.com>;
> > > Yehezkel Bernat <YehezkelShB@gmail.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>
> > > Subject: Re: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
> > >
> > > Hi Mario,
> > >
> > > On Fri, Feb 04, 2022 at 12:28:18PM -0600, Mario Limonciello wrote:
> > > > Various drivers in the kernel use `pci_is_thunderbolt_attached` to
> > > > designate behaving differently from a device that is internally in
> > > > the machine. This function relies upon the `is_thunderbolt`
> > > > designation which checks for a specific capability only set on Inte=
l
> controllers.
> > > >
> > > > Non-Intel USB4 designs should also match this designation so that
> > > > they can be treated the same regardless of the host they're connect=
ed
> to.
> > >
> > > Not objecting this if really needed but since USB4 is supposed to be
> > > transparent to the native (tunneled) protocol, I would rather try to
> > > figure out if there is really need to change driver behaviour
> > > whether it is connected over USB4 or plugged natively on the PCIe slo=
t.
> > >
> > > Can you elaborate a bit what kind of functionality needs this?
> > > Perhaps we can figure a better alternative?
> >
> > In the AMD GPU driver we use it to determine which dGPU is built into
> > a platform vs. externally connected since the internal one uses ACPI
> > for certain things and the external one does not.  There are probably
> > other ways to determine this, but it's not in place at the moment.
>=20
> Can't you check if the device is behind a hotplug bridge? Then for certai=
n it is
> "removable".

Unfortunately, most (all?) of the root ports on modern platforms are hotplu=
g capable even if the hardware is soldered to the board.

>=20
> The other option is to look for ACPI companion (ACPI_COMPANION()) of the
> device. AFAICT dGPUs don't have one (as the BIOS does not know in advance
> what will be connected to the hotplug ports) whereas internal does typica=
lly
> have one.

Yeah, this is probably the right way to do this.

Alex
