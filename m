Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2413F4AC2FF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 16:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345371AbiBGPXs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 10:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358359AbiBGPA1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 10:00:27 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE7C0401C1;
        Mon,  7 Feb 2022 07:00:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf7hdowsQAPSwZt3Wi8FbyH01Xs/UgZz5UJ/3nzmfDsC99EdY0De5U6MAKrxQ77Pa4tCOiSSyDotGOx82rg7FKD9gW5qLVW0f7M/HemS5AiRxoKzluEEQGOZMhbxvhaee6F1cMi4Jb91QRGpISwaZLQYYCzQeWw8SabNWm54LhWESMKfUFg3aU9IVXh3pEuxJJmIueF+ycA5ut0Kp7Br9kmQXD0l4h60TWnRegvoFS2z3GWvVrmF+S4i09FfRDdLiyIilOD6T/PRmo2wMkq8xNXufqXH++09qhQ8hAKgo/XCgWosm+CRxCn4sPx+7C+kcNwJhruCcR3EQH9miitsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdSN06sFX9HHs9TCyy4AmyO8E61WVVPvHzEnmPL0aBc=;
 b=UpKU+ahwF9QSoWpHY+0oUhyX81peepD1DuFrWL3DfFxLdnhYEPVoV7Q0joqVXjR9OLwgfQLFW+Cx4xR6/FWxKNSd+1vmIhhb4z2Dhr3HoZnBP3gfAhdEBsrGFzmkVVE+jnx5tReyLVoFAy0CxuGAKvxBraBMW4h14oIJEdqgvuyRtLxELPHAWr86PSO4tsTY6e12kgnHOcTKdn5Gn7Wj5KrldkqBxoWnAA0os+WuGhPZ+UhXnY0g5AlWuDM3tJSAs/cVgjWPqFV5Y8ot9TBEd527/Y528YfFCxBT3RX5KZB8uRv0ACds1z7KN1z1w7htgyXXTGVMVGde1LgrJqdfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdSN06sFX9HHs9TCyy4AmyO8E61WVVPvHzEnmPL0aBc=;
 b=NyLKvaFxv4JdGaWWzzzOmoGZb5ycoJl9aND7nedAFKGwgdIWNTQESb2EaJ3yVHtzGmNaI5P6NhyJxyjfQj6oWVJKaApIhAfcfWtMrS4Ozd9M50fAg/9iQ065DsfpJZrZPzRD48tXLBAx8dL2vWecafeyjN5buT3KQoGsvQdsPRI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB3693.namprd12.prod.outlook.com (2603:10b6:208:159::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Mon, 7 Feb
 2022 15:00:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 15:00:19 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: RE: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
Thread-Topic: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
Thread-Index: AQHYGfUZ8uN1dYeam0W687TAa8QHVqyHp7CAgACJyAA=
Date:   Mon, 7 Feb 2022 15:00:19 +0000
Message-ID: <BL1PR12MB5144B3A3F70AE921721E1397F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220204182820.130339-1-mario.limonciello@amd.com>
 <YgC/NQFN7yOffKv3@lahna>
In-Reply-To: <YgC/NQFN7yOffKv3@lahna>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-07T14:55:14Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1eb29f6c-51cd-4e09-9f72-ed2a2a06ba6b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-07T15:00:13Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: b9875dcc-c872-4a96-ae21-a726964e0718
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d85c462-5d95-47ba-1a4d-08d9ea4a8ece
x-ms-traffictypediagnostic: MN2PR12MB3693:EE_
x-microsoft-antispam-prvs: <MN2PR12MB36937E9F1FE64ED810832F3BF72C9@MN2PR12MB3693.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xsGF/NU0J6yMq259I4YL7BKfqkSfzJ/nDpxdEgg4M3oqnGYUTOS/mCOnY6b46GXoQ2fdcza+j0ydN1DTG2OceIQVB2U5xwtx4h4XYuas0FP4jbw5Gz3nXAfrATkXAt/OFAonE/OrYHtiwmV+NtVNpZHLHLOYpu1c8kD+/CiL6dxZxtQ7iviXyiQugO9VbpwWEuZzRAJd4t/ZyTkEtS5cT4Hf3QwRkeKfZFENofs+u5LZG2ZePMVZaxe3zdyiHKQEWNOYVaaqJ+O/lHF+3vym4ygw4GOuTS4DLeXyqVEQP6SLsmmcEphhI2qRrZQxK0gtz/xNUvllEQulC0CCTPDClJWX0AcJ3TMUzu+5pqaNqQ3w9IBYsE89MrF52MVZTP0AGdzQ+Xa14AsDn0URTxfyv9RvnoIdzB0gU9JvLU5A+RGnITr+v7rNsTiL/z/6HDNQJhzoJwmwXr/vEl88OODXf72tuVn9GSwt4CgUIT8TTbJBRaOeXKDVh5jp1sIKSKjlCijVpIQwL5FPNsERggGH7XAA1PhEF4ury/QibrF2MFbcI2fx91hplCHVNAJbkFZacmVVYr3vx6eaMCyDDqtNW+gxOfl/OH0A5JmdEpwgG4IXRSvLBvjHmLG/oCnae2NG8kzTYlpZBUUl1ifsXQbuSXm2cVHbUmfuUXtlSvl4q78hAq0CA4L5RltnQb16zoM3YOLfKI/F1rD7djPDOZaWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(6636002)(316002)(110136005)(38100700002)(33656002)(64756008)(8936002)(54906003)(66446008)(66476007)(66556008)(8676002)(2906002)(76116006)(55016003)(66946007)(86362001)(5660300002)(508600001)(4326008)(38070700005)(52536014)(71200400001)(53546011)(9686003)(6506007)(83380400001)(7696005)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IuHTVnXcqq63WDo2EV/zi/h1NExbR04+pM3GRxinz6zcc7dfrQOF0hM6eGYd?=
 =?us-ascii?Q?U50gaCDghCzC0d5TA1SQHgqvWv2BcitCcrcQ1PqIXKmJhJMp4RVnHigDSKV1?=
 =?us-ascii?Q?1AOCS8eJ1IrzLIhzgV0P6LfupvTnS6rxnZEvmVVB+YtJZQW/Ft6/GsJMvi5l?=
 =?us-ascii?Q?4/AF5TQZI6VKx3c3Enx0FJztPmKOSVkzMqSHbYL/H1bCSLIkCO5C0SGv87Xe?=
 =?us-ascii?Q?JVW+Y/VjPlVN2ElNaVVDEyLg8lkgLX3w0Lohy0BbCiEDLzQ1M0XQzTP81oo2?=
 =?us-ascii?Q?q8CwHQwxHQuqMWO2pMm1uhTmWAYfHAHJfBvmYJNBvlhmIErFTlSqfTN0Rjc5?=
 =?us-ascii?Q?M3Oi9O1yk/ivKM/16UppeA8rWC+1UtzwKYs1Y8gIc3flOIYr+sksUaqsRlji?=
 =?us-ascii?Q?NVNxQ+G+SMwbKsTvvvWGp5LpI44lMjRMF6iwZ+qUztwdK0xvIW2MlcPDIn3V?=
 =?us-ascii?Q?Tj8AjcfmP1YzVBwXUthsTX59tfwDsCqi8LNfnEoOwIRbPTzB+a5Mn5GDV+oI?=
 =?us-ascii?Q?USTt2uAGXtN7HvShrlaY91YchkjvZKi55UgsVs0wxrfdazpRwvexd/KxKnqU?=
 =?us-ascii?Q?zyhJmJV37y+drJvu6+6xcmPLbqW37PgI2rVk6vI7rghyzU4h5CuVLCoIbzpa?=
 =?us-ascii?Q?lUEPAJIL0zmGKkHoJdPcpTrCs7UXTmn727vRmRmOzwRbkogWVoxUCKKFGxsr?=
 =?us-ascii?Q?D5Et9KWBJ/bagbG+WZRmr1RQq+XdvCD2/URt6mMr3ZXk8aDwl+KiQJBgIkk2?=
 =?us-ascii?Q?u/3IIwaw/aIe+2TfwE/3Fz4nlgf8Slkl2+05ecBBZmdRkoL3J2CtzXL7Ruwc?=
 =?us-ascii?Q?qQgQahECJNjoA6vwuj4575ANnZNfCWqsxIEsJcFAlmJqRpeIxVuNeTEfWIwn?=
 =?us-ascii?Q?u1P4wywXoxyVknt8e+HTM02tONAdDS9Blha+XgeL4JKN4KiPSl8nEsjAy0NY?=
 =?us-ascii?Q?OoZMnN4SVBNodSga5D6u86XWEzRmRC2PAjYR1RYDRn7D3nXTkNJw9jBcyN5i?=
 =?us-ascii?Q?PQDE1eXR3Kjv6Xav3Q+DcoCjc55AlJzUBrYRo6B4mEN/MVq49CKHDEtPLs5F?=
 =?us-ascii?Q?9TUH/xaxsDDrKpWY1jWF6n/xlu9nIyvL0Pld0t+xJ5UPsE43c7CY/d554QAH?=
 =?us-ascii?Q?/wo2dLbgwG2NS+4ZEP/Z5rg8vLwc/qwH7xkubvrXx/t0q0Kfm8s8zafrPnjD?=
 =?us-ascii?Q?ZKLtyUl3F43FC4Wyhh4m/8Iqq5qnHlx2LiP/6I5zxxHJMiqoD9jD96mnk0wl?=
 =?us-ascii?Q?M6Oxu7ePu/BcqMlyJhWEC1uqmjNepDM+oDIW0xQAYmgP/vMpdIsYbLAlj/LH?=
 =?us-ascii?Q?DAh+iTB9ceJZV0ahrcmlVfSMVuGwEQ0fucGoQsiirc1jQ8fvvRO/YtB8ThWT?=
 =?us-ascii?Q?3JlhVHhm9Fc2fGYqbYrdNpWY7A+C1OMc8aWjyu97AdgUmGc463qP1qaCf85b?=
 =?us-ascii?Q?ye692gVVrHt31MGfcbbcjNDtPzQ/90Pf4YW3OwC1xxJkwuPWBu1weWSIoyGM?=
 =?us-ascii?Q?iuy7CcmOioOatKSV7XFH/QZ60pCs+tssFxp0y+7Osl8lmRNYxmyZpYGzJAuM?=
 =?us-ascii?Q?uULrH/IxRFHegg4yuf8MGtjYCkoSs4VxcIWH5/7OM9Nzfqg1+vSklEBb2PU6?=
 =?us-ascii?Q?jJf+zZwBJEU1tbnc1En0nAg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d85c462-5d95-47ba-1a4d-08d9ea4a8ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 15:00:19.3362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goayZ4TWP0n8eWkoN5c+lyXRikvqWN5BmuodqcOPN3JOdH/GL63rqouWiORIOHuMyP8Dj0fgcESFloWCaRd2rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
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
> Sent: Monday, February 7, 2022 1:42 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Andreas Noever
> <andreas.noever@gmail.com>; open list:PCI SUBSYSTEM <linux-
> pci@vger.kernel.org>; open list:THUNDERBOLT DRIVER <linux-
> usb@vger.kernel.org>; Michael Jamet <michael.jamet@intel.com>; Yehezkel
> Bernat <YehezkelShB@gmail.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
>=20
> Hi Mario,
>=20
> On Fri, Feb 04, 2022 at 12:28:18PM -0600, Mario Limonciello wrote:
> > Various drivers in the kernel use `pci_is_thunderbolt_attached` to
> > designate behaving differently from a device that is internally in the
> > machine. This function relies upon the `is_thunderbolt` designation
> > which checks for a specific capability only set on Intel controllers.
> >
> > Non-Intel USB4 designs should also match this designation so that they
> > can be treated the same regardless of the host they're connected to.
>=20
> Not objecting this if really needed but since USB4 is supposed to be
> transparent to the native (tunneled) protocol, I would rather try to figu=
re out
> if there is really need to change driver behaviour whether it is connecte=
d
> over USB4 or plugged natively on the PCIe slot.
>=20
> Can you elaborate a bit what kind of functionality needs this? Perhaps we=
 can
> figure a better alternative?

In the AMD GPU driver we use it to determine which dGPU is built into a pla=
tform vs. externally connected since the internal one uses ACPI for certain=
 things and the external one does not.  There are probably other ways to de=
termine this, but it's not in place at the moment.

Alex
