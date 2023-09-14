Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3BD79F7AA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 04:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjINCLA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 22:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjINCK7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 22:10:59 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2701BD4;
        Wed, 13 Sep 2023 19:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo9BmDOLIzbcwjghrHlAhakYbKOLry32lH2r2NvxrnxzSL3UcsLKhLOmn0MFoJYuXNPfotpYYzQiFD31Vj3wEFFYrmqnwC6ygHP4MRKBy1iE3GuRVN6lnSt45FaIsmk0OWWmfZnGm/KPlrYzg96QLdSCPNpCTOic0ewBxwuX2NZBBr3fwK0hWUp5GuN+874Tq3LTvBMMW7IuEvzRFLHUjAt4q6itIplx4PuLxSOWjSRGWzxyN161X1T+ZdJdr+hUq5oAN4Kk/e8kpvB9wt1pdi7Jta1x5iQ6hO3vVCp4VtAodefW+st+Gk94ZJOLao5/SGVd80EWxSdN18fYoHV5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peWxTV+Gw9EqUEK3BqSPyalMRGQLeqF2EBFJngDIkFk=;
 b=KTQUZ9u2Vn7iH0rumDreHXkyMdWAaAKiABzzzSsgVlI+8fDcw5TN9DuPu4HcycMnESTXyH0NOT9oFS1cgCdO4f6eLbiQXgiuWCNEAjxuIp5YuJW+DtBPkVCvfHcqUYXdigx2WgmETOs495a76cJMMJJy3kDTMzRefGW2fy4TSegHz8XFZ5NjkhVji3985+N8oBNlyShREM7OOzNw/KyqCJ1rX3jIwQR0N5LyFEcPyKzpCK05mPbRIK786/BNokyO8HRqA2qgQSQVpWW16FZu9RXe4y4kj8T6r7UwxTXxQ/r/PNMzqzpj9R8sgpOIg1alZQqyMm/mm4j/5ZL1Jmm6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peWxTV+Gw9EqUEK3BqSPyalMRGQLeqF2EBFJngDIkFk=;
 b=ibCWc5ElRywFvMfTKFPLZOstzOttfNVJ4qExKJWODj6sWNOqYq59RcsdJhPVGVl7yuQdiBMVP2CF48Gb4hF/FiSbobsyNYE9fNQ3ickROqTXQXPHYaMPks6JrT5WIEcKA+Y3UGHhtv+ZPb3TzYQzd5D8akWVCMFpk5zBy7gGuhY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 02:10:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 02:10:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Thread-Topic: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Thread-Index: AQHZzxhuyRkzZgDao0KEaKWaunEMhbAX8PmAgAAxQqCAAA8+AIAACMAggACakICAAO0HAA==
Date:   Thu, 14 Sep 2023 02:10:50 +0000
Message-ID: <DU0PR04MB94175EF2754D45D010F21F1188F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB941790B85BCDD60ACA2601A588F0A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20230913115737.GA426735@bhelgaas>
In-Reply-To: <20230913115737.GA426735@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB7006:EE_
x-ms-office365-filtering-correlation-id: 8271ded6-b3cc-46f1-d2b6-08dbb4c7d193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0G/hNOr112IGyBwlfqwQNLx4WMnCacKnQl0TJEnO7lsZi7Lt4aYtT4/ly44QDsaAWA/LlzFOUVukDq7lLXorBCF5j/LOQigRAC9ckUJNqKmo0u3RXZiqfQTfOr6qq2sL58R0/Zg4tmT748pbuHcaUJ/jT9nMioBY8SeEc1OlHS1MrrH5CyPal4cYx7aql5uAs0n+OH06UPIAuvLaALKrWrJDh7HV3oDqSTIJXJgZNKiJK9YaspLOZRGjeaMUDsySdj8/bV/vgKTeM4sR0LKKtoGqdWIXcq56bwCbmxpyIxqDa0asiOYIoQ1jbGoMsAGbOxJWfCnD4Pb0qnmNivLHat9af+oCF/qisoB5OKbO4rcubwS8cbyHxrHDrRlQaPGZAWystrd0/PWrI9rAroS9T/LeNo+dwZuHRwxlYERMIOiPxsUM9k4AUv7Ul3zZmItw7KiYz6Cdt2ywYtk4+T5/0W9Yg/EEOLi3iunxdbkj+Ths4w0Uxlef7FxlmuYvUsFZCn3aNzg7iZi4IidV6Y856htznqfxHrd8snZ+su0+25Fvuy27qICxZFvMjAtlFyyDLMIjJuVvEc4GL7THMJlhludD5GLGzMopPmhF3GyVTmI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199024)(186009)(1800799009)(5660300002)(38070700005)(45080400002)(122000001)(71200400001)(38100700002)(44832011)(478600001)(2906002)(966005)(30864003)(8936002)(4326008)(8676002)(55016003)(110136005)(41300700001)(316002)(76116006)(54906003)(66476007)(66556008)(66946007)(64756008)(66446008)(52536014)(83380400001)(26005)(33656002)(6506007)(7696005)(9686003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Rn/nN6u8tPt589L0JBTcupdWafqsntqR+T5O4qwMZoA3gXG6eTgKahXMCTI?=
 =?us-ascii?Q?uft1Ary1bAfg/aj9Scqk9tcE6PrV+Q4BQHP6EzE9qhMAcDSRBFR3NsspCHdB?=
 =?us-ascii?Q?6EtGgQ/LQ4bDo0mkY69JrEmY7bquwiegP0wOUsrkoVxUXsqNPpruhlC5qN7g?=
 =?us-ascii?Q?Bpjlrr7/SbvP6rVkUAk5kPwCE/KozsDA8+DI+tM8GWIdHLdBBAxiI7uOToTI?=
 =?us-ascii?Q?0tLsWn+PWid1AXLgG6G7ilqLKzu0kIWrNlns7prrE9BuG2m0/1qZysEcGrVV?=
 =?us-ascii?Q?RrPui0ZlghSd0POz8oR6OTrwODONuuzOgKo3yM6LaBMFyHmiwtKrDZ+xZ7rW?=
 =?us-ascii?Q?emoKkfpfXkIPUUhaYqlxflA5Yqs2eleTwCQaFcdvD9Wq65qGJFj6/SZO5ymg?=
 =?us-ascii?Q?BOx8OypIjeL9jgzqRAVcWYiaNVwIYlFx3S8YybNcWzFiElAawK1B5C09jd4t?=
 =?us-ascii?Q?PeyKtWTJtBzYleX4DrgKR63/fyCBrfaDTrNgCRYncHrn6VQAxSgCyMdRg4QY?=
 =?us-ascii?Q?CAWDe9Yq3bsHwNUqoInNthbGeQRDxTj4DfGEHD5g9b2nkPLFgNnYCXxluI8k?=
 =?us-ascii?Q?n3Dh3tAYvLSmkrlk3Lof+VvpVmwhfLHACxUJQLu8Xb/HogeAkJWouP6/iwj4?=
 =?us-ascii?Q?903tMqTEy1ELGeTEOowtfgAP9i5DqSmDxsfXGxMx28QAFju2r8NO/m1syaL8?=
 =?us-ascii?Q?c4KZvHBPX8t0+HLRqcd5yzNgroZionfdYynS8E6tVs8ibJQXu+MwQ7SvNICj?=
 =?us-ascii?Q?JPpvNjEZCPD+aQgwMERG8AVDKP8hSsMqy/ubd76snjhRZfHCgUb8BF3yFerZ?=
 =?us-ascii?Q?1sjnN/coL8PSQfz951f/NoUEWrG3HYPZ2Sgeizodud64WuxbxemJhq+NKOWx?=
 =?us-ascii?Q?zDvY2z3nf9SChb8Us4c/09kj+8e1tmqfIhk6l9uzCBKd13juYraHtBRrEexi?=
 =?us-ascii?Q?jizK84UxzGRC3zFh2kGdIoiEZmWVsrxE30WULXQM/w+o5GmBmU21A7zKFx9W?=
 =?us-ascii?Q?OqPrACO4FNCoI/t51xmnewFDomnuh3c0ojBKqhVOPt6ptV1tbUAGVlCzLimo?=
 =?us-ascii?Q?KzYg0jVOXM1srH+qck5BcETNO3SvjJQSIkWnwmqmFkoxDp8ukrbMRVPzdWSB?=
 =?us-ascii?Q?rbpeOoRXJEI3B4wAMedFb+H6P2i0+CksqQY51DEdA0bmQTGTHjxUfw9KvVQL?=
 =?us-ascii?Q?rOptiKtfaX6igsV1iWO/aw0h7zJIzMChyr2SIlhxLm2/qJyX8k36+oHJKgw3?=
 =?us-ascii?Q?9cPVyvLxLn/QSTdO8NPhaWe2L/O1rnGvds5+XvXC8HS+59x3kntBsxTI0gtR?=
 =?us-ascii?Q?ENl1d0frxhqzKFs9JfcE2RquOpvQirnQWv5U6+MCjjtvcv+2iSdF/AUHB9AF?=
 =?us-ascii?Q?Yc2LgY3/Fh9jMOqchsO8XfO3QFmhODpAI7T+XHS2jNZRTBDGx1e/sE93aJid?=
 =?us-ascii?Q?XHL/Rn27wQO4BBu5q5ujIM4NI6XjDZccYmU4xD1Mj95nX+WbX0UIkCg8auSX?=
 =?us-ascii?Q?visVWOzHZ7DuaM8InUEHILE78HYKgawnk5Cn7bCvun0h0sVSdYvUHzU0iFcd?=
 =?us-ascii?Q?m3BfAHE+K/5gMb+DVFw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8271ded6-b3cc-46f1-d2b6-08dbb4c7d193
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 02:10:51.0508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vu92joUskhCE7zOBPM8rvdjIPeO8MtAxHimPZDGMfmyFIWLG6nOCBDzUeExrTiZ4REvuvVdOfgQuKJpkJmOIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+DT maintainer and Jailhouse maintainer.

> Subject: Re: [PATCH V2] pci: introduce static_nr to indicate domain_nr fr=
om
> which IDA
>=20
> On Wed, Sep 13, 2023 at 02:49:37AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH V2] pci: introduce static_nr to indicate
> > > domain_nr from which IDA
> > >
> > > On Wed, Sep 13, 2023 at 01:24:26AM +0000, Peng Fan wrote:
> > > > > Subject: Re: [PATCH V2] pci: introduce static_nr to indicate
> > > > > domain_nr from which IDA
> > > > >
> > > > > On Tue, Aug 15, 2023 at 09:37:44AM +0800, Peng Fan (OSS) wrote:
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > When PCI node was created using an overlay and the overlay is
> > > > > > reverted/destroyed, the "linux,pci-domain" property no longer
> > > > > > exists, so of_get_pci_domain_nr will return failure.
> > > > >
> > > > > I'm not familiar with how overlays work.  What's the call path
> > > > > where the overlay is removed?  I see an of_overlay_remove(), but
> > > > > I don't see any callers except test cases.
> > > >
> > > > We are using an out of tree hypervisor driver:
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > >
> gith%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C8861187acb1644109
> 5b808
> > > >
> dbb450a3f3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63830
> 20306
> > > >
> 79270146%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luM
> > > >
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D55kRQ1
> 0CXF
> > > > vA5LLjO285wkk%2BPrTKdaQYUTrBYF5UkxM%3D&reserved=3D0
> > > >
> > >
> ub.com%2Fsiemens%2Fjailhouse%2Fblob%2Fmaster%2Fdriver%2Fpci.c%23L
> > > 483&d
> > > >
> > >
> ata=3D05%7C01%7Cpeng.fan%40nxp.com%7C1bf0364c585f42dae7f108dbb3fe
> > > fcc4%7C
> > > >
> > >
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63830167996269745
> > > 6%7CUnknow
> > > >
> > >
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > > WwiLC
> > > >
> > >
> JXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DraIsz2HIH%2FQ0nmolBBwd81
> > > WxQh2vmFeXN
> > > > t3n6OIQaSU%3D&reserved=3D0
> > > > >
> > > > > I guess the problem happens in a PCI host bridge remove path,
> > > > > e.g.,
> > > > >
> > > > >   pci_host_common_remove
> > > > >     pci_remove_root_bus
> > > > >       pci_bus_release_domain_nr
> > > > >         of_pci_bus_release_domain_nr
> > > > >
> > > > > But I don't know how that's related to the overlay removal.
> > > >
> > > > When the overlay node got removed, the device removal will be
> > > > invoked and the domain number indicated by linux,pci-domain should
> also get freed.
> > > >
> > > > But actually the domain number not got freed because of bug as
> > > > this patch shows. "of_pci_bus_release_domain_nr will actually use
> > > > the dynamic IDA, even if the IDA was allocated in static IDA."
> > > >
> > > > So after the overlay node got destroyed and our test recreate the
> > > > overlay node with same domain number, issue triggered, the device
> > > > could not be created.
> > > >
> > > > > Is this an ordering issue?  It seems possibly problematic that
> > > > > the OF overlay is destroyed before the device it describes
> > > > > (e.g., the host
> > > >
> > > > No. it is "of_pci_bus_release_domain_nr will actually use the
> > > > dynamic IDA, even if the IDA was allocated in static IDA "
> > >
> > > Yes, that's the *symptom*, to be sure.  My question was why the
> > > overlay was removed before the host bridge.
> >
> > I am not sure.
> > I added a dump_stack, would this help to understand?
> > root@imx93evk:~# jailhouse disable
> > [  595.150529] CPU: 1 PID: 582 Comm: jailhouse Tainted: G           O
> 6.5.0-rc4-next-20230804-05021-g3d4cc14b42ef-dirty #355
> > [  595.161998] Hardware name: NXP i.MX93 11X11 EVK board (DT) [
> > 595.167475] Call trace:
> > [  595.169908]  dump_backtrace+0x94/0xec [  595.173573]
> > show_stack+0x18/0x24 [  595.176884]  dump_stack_lvl+0x48/0x60 [
> > 595.180541]  dump_stack+0x18/0x24 [  595.183843]
> > pci_bus_release_domain_nr+0x34/0x84
> > [  595.188453]  pci_remove_root_bus+0xa0/0xa4 [  595.192544]
> > pci_host_common_remove+0x28/0x40 [  595.196895]
> > platform_remove+0x54/0x6c [  595.200641]  device_remove+0x4c/0x80 [
> > 595.204209]  device_release_driver_internal+0x1d4/0x230
> > [  595.209430]  device_release_driver+0x18/0x24 [  595.213691]
> > bus_remove_device+0xcc/0x10c [  595.217686]  device_del+0x15c/0x41c [
> > 595.221170]  platform_device_del.part.0+0x1c/0x88
> > [  595.225861]  platform_device_unregister+0x24/0x40
> > [  595.230557]  of_platform_device_destroy+0xfc/0x10c
> > [  595.235344]  of_platform_notify+0x13c/0x178 [  595.239518]
> > blocking_notifier_call_chain+0x6c/0xa0
> > [  595.244389]  __of_changeset_entry_notify+0x148/0x16c
> > [  595.249346]  of_changeset_revert+0xa8/0xcc [  595.253437]
> > jailhouse_pci_virtual_root_devices_remove+0x50/0x74 [jailhouse] [
> > 595.260484]  jailhouse_cmd_disable+0x70/0x1ac [jailhouse] [
> > 595.265883]  jailhouse_ioctl+0x60/0xf0 [jailhouse] [  595.270674]
> > __arm64_sys_ioctl+0xac/0xf0 [  595.274595]  invoke_syscall+0x48/0x114
> > [  595.278336]  el0_svc_common.constprop.0+0xc4/0xe4
> > >
> > > The current ordering is this, where A happens before B:
> > >
> > >   A overlay is removed
> > >   B pci_host_common_remove
> > >       pci_bus_release_domain_nr
> > >         of_pci_bus_release_domain_nr
> > >           of_get_pci_domain_nr      # fails because overlay is gone
> > >           ida_free(&pci_domain_nr_dynamic_ida)
> > >
> > > But if the host bridge were removed first, the ordering would be as
> > > follows, and the problem would not occur:
> > >
> > >   B pci_host_common_remove
> > >       pci_bus_release_domain_nr
> > >         of_pci_bus_release_domain_nr
> > >           of_get_pci_domain_nr      # succeeds in this order
> > >           ida_free(&pci_domain_nr_static_ida)
> > >   A overlay is removed
> > >
> > > Is there a reason the overlay should be removed before the host bridg=
e?
> > >
> > > Obviously the overlay is loaded before the host bridge is created,
> > > and symmetry would suggest that the overlay should be removed after
> > > the host bridge is removed.
> >
> > Hmm, I need check more. But do you think this patch is fix a real
> > issue or If order is did as you say above, this patch is not required a=
nymore?
>=20
> It looks like you're using a notifier call chain to remove the devices wh=
en the
> of_changeset is removed.  I think that's the wrong approach.
> The only in-tree user of of_changeset_revert() is i2c-demux-pinctrl.c, wh=
ich
> uses the ordering I suggested:

I am not sure whether it is a must to first delete the host bridge then do
the revert from dtb overlay design perspective.

Thanks,
Peng.

>=20
>   i2c_demux_activate_master
>     of_changeset_apply               # add OF changeset
>     i2c_add_adapter                  # add device
>=20
>   i2c_demux_deactivate_master
>     i2c_del_adapter                  # remove device
>     of_changeset_revert              # remove OF changeset
>=20
> > > > > bridge) is removed.  I would expect the device to be removed
> > > > > before the description of the device is removed.
> > > > >
> > > > > > Then of_pci_bus_release_domain_nr will actually use the
> > > > > > dynamic IDA, even if the IDA was allocated in static IDA.
> > > > > >
> > > > > > Introduce a static_nr field in pci_bus to indicate whether the
> > > > > > IDA is a dynamic or static in order to free the correct one.
> > > > > >
> > > > > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by
> > > > > > ida_alloc()")
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > ---
> > > > > >
> > > > > > V2:
> > > > > >  Update commit message
> > > > > >  Move static_nr:1 to stay besides others :1 fields.
> > > > > >
> > > > > >  drivers/pci/pci.c   | 22 ++++++++++++++--------
> > > > > >  include/linux/pci.h |  1 +
> > > > > >  2 files changed, 15 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
> > > > > > 60230da957e0..5c98502bcda6 100644
> > > > > > --- a/drivers/pci/pci.c
> > > > > > +++ b/drivers/pci/pci.c
> > > > > > @@ -6881,10 +6881,10 @@ static void
> > > > > of_pci_reserve_static_domain_nr(void)
> > > > > >  	}
> > > > > >  }
> > > > > >
> > > > > > -static int of_pci_bus_find_domain_nr(struct device *parent)
> > > > > > +static int of_pci_bus_find_domain_nr(struct pci_bus *bus,
> > > > > > +struct device *parent)
> > > > > >  {
> > > > > >  	static bool static_domains_reserved =3D false;
> > > > > > -	int domain_nr;
> > > > > > +	int domain_nr, ret;
> > > > > >
> > > > > >  	/* On the first call scan device tree for static allocations.=
 */
> > > > > >  	if (!static_domains_reserved) { @@ -6892,6 +6892,8 @@
> static
> > > > > > int of_pci_bus_find_domain_nr(struct
> > > > > device *parent)
> > > > > >  		static_domains_reserved =3D true;
> > > > > >  	}
> > > > > >
> > > > > > +	bus->static_nr =3D 0;
> > > > > > +
> > > > > >  	if (parent) {
> > > > > >  		/*
> > > > > >  		 * If domain is in DT, allocate it in static IDA.  This
> @@
> > > > > > -
> > > > > 6899,10
> > > > > > +6901,14 @@ static int of_pci_bus_find_domain_nr(struct device
> > > > > > +*parent)
> > > > > >  		 * in DT.
> > > > > >  		 */
> > > > > >  		domain_nr =3D of_get_pci_domain_nr(parent-
> >of_node);
> > > > > > -		if (domain_nr >=3D 0)
> > > > > > -			return
> ida_alloc_range(&pci_domain_nr_static_ida,
> > > > > > -					       domain_nr, domain_nr,
> > > > > > -					       GFP_KERNEL);
> > > > > > +		if (domain_nr >=3D 0) {
> > > > > > +			ret =3D
> ida_alloc_range(&pci_domain_nr_static_ida,
> > > > > > +					      domain_nr, domain_nr,
> > > > > GFP_KERNEL);
> > > > > > +			if (ret >=3D 0)
> > > > > > +				bus->static_nr =3D 1;
> > > > > > +
> > > > > > +			return ret;
> > > > > > +		}
> > > > > >  	}
> > > > > >
> > > > > >  	/*
> > > > > > @@ -6920,7 +6926,7 @@ static void
> > > > > > of_pci_bus_release_domain_nr(struct
> > > > > pci_bus *bus, struct device *par
> > > > > >  		return;
> > > > > >
> > > > > >  	/* Release domain from IDA where it was allocated. */
> > > > > > -	if (of_get_pci_domain_nr(parent->of_node) =3D=3D bus-
> >domain_nr)
> > > > > > +	if (bus->static_nr)
> > > > > >  		ida_free(&pci_domain_nr_static_ida, bus-
> >domain_nr);
> > > > > >  	else
> > > > > >  		ida_free(&pci_domain_nr_dynamic_ida, bus-
> >domain_nr);
> > > > > @@ -6928,7
> > > > > > +6934,7 @@ static void of_pci_bus_release_domain_nr(struct
> > > > > > +pci_bus
> > > > > > *bus, struct device *par
> > > > > >
> > > > > >  int pci_bus_find_domain_nr(struct pci_bus *bus, struct device
> > > > > > *parent)  {
> > > > > > -	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
> > > > > > +	return acpi_disabled ? of_pci_bus_find_domain_nr(bus,
> parent) :
> > > > > >  			       acpi_pci_bus_find_domain_nr(bus);  }
> > > > > >
> > > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > > > > > eeb2e6f6130f..222a1729ea7e 100644
> > > > > > --- a/include/linux/pci.h
> > > > > > +++ b/include/linux/pci.h
> > > > > > @@ -677,6 +677,7 @@ struct pci_bus {
> > > > > >  	struct bin_attribute	*legacy_mem;	/* Legacy mem */
> > > > > >  	unsigned int		is_added:1;
> > > > > >  	unsigned int		unsafe_warn:1;	/* warned about
> RW1C
> > > > > config write */
> > > > > > +	unsigned int		static_nr:1;
> > > > > >  };
> > > > > >
> > > > > >  #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
> > > > > > --
> > > > > > 2.37.1
> > > > > >
