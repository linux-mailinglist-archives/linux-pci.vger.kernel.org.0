Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF53062B24B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 05:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKPE0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 23:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKPE0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 23:26:08 -0500
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEB6C9;
        Tue, 15 Nov 2022 20:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1668572766; i=@lenovo.com;
        bh=OL3n5/oKMUysbGWzOZ2QgzgIvdoN7JYcf1FTbjnGdXQ=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=mLAwQXACJLMMaNvjgTkUx57QTC4ffq0B2i9iMvEDwnXIqZZR55ikoNNfCrSOYa4Oe
         yweMA46Yg1/L6DM2+gkMUccmo/ewXjVZxEfHmZ8YuMpfiEVNSUVlbS/DCu5r3c7ygp
         UVR4CleBk1ks3fJY2p6124IFjfJo8co+hGfbt642X1jnLI8F+cF6HU6f+Yiu3CNCvJ
         5giO6UZw7BfKlw0g0z58rYdMixAE57ZvNVF/3YfgekTAoYVsj37w4rXs4241wL1lHy
         KCwVyozxY0+cCbXum//3uYo5pDyrmYCweGMrFJTha2+Hz4EZnKWYMYGnRgHNB5t8qo
         q1c6MzoJUweIg==
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTcUwTVxzHeb3r3UFaPQqMB0FMGtlmsR1Ktpy
  YKBqnzRYZGlk2NqYHHG1jW8hdUWAxqwhlFlAyKSLTAlYIdGscBAcMEMbYEFSaAcOFzDAm2yIz
  kwCuRIqs11PH/nn5/H7f3/ve917eIxCZGY8kmDwTwxppvRwLQrWvRW5VpmWZMuJqRwjqaqGWm
  r3twqjmommEMpcti6mxby5h1B37IEZ1ustxqshbhFJj9Vuo1e4OPDFI7WiqFKvrWnPVrc4zmH
  pm/IJIXW+2IWr70EH1Qmt0Mp4q1hnTs/OOirVuy2+iHMfmvHMdcyIzaJJbQRAByAYEFo11AaG
  4IoYumxsTiq8ALH2y4FdkpF0Efz9rRYRiCsA+5zhqBYEERipg9bde3AoIIpR8GVpLUvgZhBxA
  4K2eRcDPhJBZcNqygPEcSmpgZekTXOA9sL2pD+EZJWPgxcY//X0pmQYH7n0qFj5WCKDXeVrMC
  4FkHBxZvuk3AuRL0DP8pYhnhAyHkzO1foYkCa92uxGBw+CD+0/FwrwJTj64hgn9DXC0thTwoS
  G5C9bPpAntA/B652dA4GjoLJ9GBd4Iq648wgWOgr/+3P7MxovB5sUIPickH6KwZOLysw1x0P7
  PACYIdhIuFf+AC0G3wLqueUzgWNhY/xdSAWJr1vxDzZqxmjVjNf6DCYZDF2fQOoA6wescwx5n
  WCWlSmd1Gq3JQOv0KrpASatyOeUJhjMpt6noE5yK4TgVl2/I0GeqjIypFfguXSZLT3aA3kavq
  h9EECJ5mJTYx2XI1qVnZ+ZraU57hM3VM1w/iCIIOZQaLvu0YJbRMHlZOr3v6j6XISGRh0qjzT
  5ZyuXQBk6nEaRh8CYx/nVPD0K4O3t9q+3zp70I0XrD2ocQZ3p9qww1ZhuZyHDpOt6b5Ddrc40
  vrJ8/jFGwITJECgICAmSSHIY16Ez/12dBOAHkIdKxap+LRGc0vUgw6wsn8oXrS2L5cCb6PynS
  LAqreL/Q84ujPn5TlUMR89FESRf6RttIW+K9nS17d3+oqWq/aZGVVMcXTOW6Nv04nHirs8lQH
  HTHg50639mxv7JMPNOWum+uB56bOmDBFZqiRervTzza8pajry5lDaV9sT/qbGKIq9L5gcfy1n
  eW+fNYRf5hG/0wX7HzdFnC3bz5slj1dolronA4+HFv0kp3+LUWtnqJTYkYGCxwXwAVnhsr1Ob
  +pLuNhX2On96Z23g8uUl8+7563nE9nktdvwOzvNtV/Mrb2ubUI8f+eKTOX+24tHdHui7m49X3
  EvD13zfgPSulUfhgQuC25WO7HiePHradbDiVotxelizZnXLItudkbUOpHOW09FYFwnL0v1QIw
  hGTBAAA
X-Env-Sender: lixc17@lenovo.com
X-Msg-Ref: server-19.tower-655.messagelabs.com!1668572763!46169!1
X-Originating-IP: [104.47.26.49]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17475 invoked from network); 16 Nov 2022 04:26:04 -0000
Received: from mail-psaapc01lp2049.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.49)
  by server-19.tower-655.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Nov 2022 04:26:04 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA578cbnZybiY22/oSNRK6ZWs42boGEiPkM1FZR5bueZqDuaAuIW18KO066OwrxREnvxxlf7ysW7DydpHzl6naUQgDI4ml91vZULbIs8L5U4/a3OkRWVkhb5NMJoW7VdVHGKw6wrr5P4MBxvbgZt5jL1kVOrBhHtIgYouvSRGGmEpN90P3wyfw/CiJlVXgoG41HAi2cRWGWj7Ma8RnsEBCGzXZSmL7QhTDyTgRMnb/0Iac926JySCfxyf1cZoQsB3W8V1WLSDTZvfOR2bQCdfLMVJfv9gjosA+IFmPG/F6CTH+/xGJPVRlNYm8xR/bkb4PL++6rzI1M2OqCB80CD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL3n5/oKMUysbGWzOZ2QgzgIvdoN7JYcf1FTbjnGdXQ=;
 b=JmDqU0i861lsDwORXQrvV7DWB8h23stzYnk/Q7Uh5TkqVrJmabsxiT+cLm+6bcNwPZa0xo7K6enc6f2CKrRMErnx8S1FXkUdnGcur3D0jZAzKAsXxH5babP125NIjfGtT3rqwMTRBNOQLCLFCCgjaup7N+xBEzBfC3wtrPGOWbojTVue/XEabI15RxvIuhwcl+2lN6kK1G0iXwg7XniVcDxoePtziZBtbvx2/nHY0xwjq8zTGa/ei8srjrTAiqEPUdofpRcRfbo4y7bkT9AUT12mYLPKu6sKuN4xvhOFCxwcw71S6ArqUPAJSmOgGdmcVUJqdiXh/9puiO/wXp+oiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com (2603:1096:101:b8::14)
 by SG2PR03MB6732.apcprd03.prod.outlook.com (2603:1096:4:1db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Wed, 16 Nov
 2022 04:26:02 +0000
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::b2a6:e182:1737:8f7b]) by SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::b2a6:e182:1737:8f7b%5]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 04:26:02 +0000
From:   Xiaochun XC17 Li <lixc17@lenovo.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Xiaochun Lee <lixiaochun.2888@163.com>,
        "nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External] Re: [PATCH v1] PCI: Set no io resource for bridges
 that behind VMD controller
Thread-Topic: [External] Re: [PATCH v1] PCI: Set no io resource for bridges
 that behind VMD controller
Thread-Index: AQHY9ijyZogN/mU3ikCFvi4cdjkRD65A5kcwgAAOsACAAAGRsA==
Date:   Wed, 16 Nov 2022 04:26:02 +0000
Message-ID: <SEYPR03MB68773929A3008A3F5C7E0898BC079@SEYPR03MB6877.apcprd03.prod.outlook.com>
References: <SEYPR03MB6877FB2A677FBBCF80E6BD3ABC079@SEYPR03MB6877.apcprd03.prod.outlook.com>
 <20221116040520.GA1078511@bhelgaas>
In-Reply-To: <20221116040520.GA1078511@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6877:EE_|SG2PR03MB6732:EE_
x-ms-office365-filtering-correlation-id: 7d949a9c-ee61-405a-7331-08dac78aabb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zg05UCDaOLFya3F+qT2QE7UJ90ZnWno0J5ruLWqKUJrHXFaQIbngz3H2aPpwjnoTJ/tuOFFyfFF3fhowo9JYYUJYpN3TPUBYQwveLF9IXfAzTOWXGrIpT3eCjnpPDCafgmAbr/RzA92SKWlnmINwEl7RxE7W63zC70nGe/EiR4XLInPs59t9ANgNGH+fwX9TgGXhkxYxdVQgp5BDa2XJ9s7n4M1i3S86q2jE2UpfXAMWM6YylBfew6Sn91e2CYp3L1bH2Lt9+tx9YtTaYbR3E5SbitfUT+tb/I8imHscIZVsBo4kXRhZm3L1kBVboVEeGZpAAvxcJ3VdlkHq1j64jfv62kiuY/VVIsqo2zEDP1RN36TPM2QZ1rgrUnN/rPw9YPffYXLTr4qeuXXZNJJtazvy29F2yFzKtZwVMz8HEhcdVJM68QGuf1w7gAchO0eo9ALAJihSVu7albmmpl6N9KZKufF7lJ6qACyLWKF8yAkc/sdW06HIWUWukej7S/z8kSM0wIG3sbu6oI+VcH1pVZHT6b8u0AmT/SQLZjSWBLdQ33dL0ng4lMen3FAJiCa/4VPeAnRnC6TvUh67zt/nIAY5UDmK5RNBvrGD0IAHQmAet2nsiW0XVIRpXyHpvEjs/llooEuqQrDYovrZHIHaPC6H6V5mkGmaOr3g+J5a8pIYAidBMQ9lF9iYHp50wvAIckXLgUqWgUZ9hjnnzbHwlRIbYQHdSWDWj9SXFg17L2RQRMpgbXdmXMMGHd+BHk3Xc09Cs+SwndMUkcnQ9fYzkhqiA9wrCdieAjJOeXDR2xCU10svmSSaGKavKKP2UXaoZDvIYMPPHSvyoj6Fll6uHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(38070700005)(66946007)(82960400001)(8676002)(316002)(66556008)(41300700001)(6916009)(66476007)(38100700002)(66446008)(4326008)(76116006)(54906003)(122000001)(64756008)(26005)(2906002)(33656002)(186003)(45080400002)(55016003)(478600001)(7416002)(966005)(66899015)(5660300002)(9686003)(6506007)(53546011)(83380400001)(71200400001)(7696005)(8936002)(86362001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qYJ8bN3XWaAG3h7A57iAzP5W4hAdgTwaAn44c4YCElBlaRtkfjSt6dDsQny0?=
 =?us-ascii?Q?3yJIp8rBMVYiP8zBvTXG5kYNdeWQ/tfGazV5gFxiA2OvVbMbmYy8Wr4fl7Fh?=
 =?us-ascii?Q?xiXu4PBh0G2pY/AbJKURNelZ86Bfs5JC4SaRlWnwOPaXW03eOMzlr96bGhuT?=
 =?us-ascii?Q?N7eYLP+eEAckqfoUbqUA0ilminWMDYmZF7aB2Rx/vE49tKGkWJmDncd8PJ2e?=
 =?us-ascii?Q?lDnwnznGmWQskrBlQK2t/FRVQxsQcfxu/zd84M94P9MKBH2xkmUUBznhr20X?=
 =?us-ascii?Q?BHcgm9BYx+Na0SdGy/D8jQkcWqNMuA3ds9mk3tHPim1cIVEAjl7RzvwHJTug?=
 =?us-ascii?Q?h/fwbRQyAmYxZ3YXwNzHSsH1ZeQVHtu3yu5x/RFjMv2UO4mxsApPZL3RQjO6?=
 =?us-ascii?Q?qhEBSEVVmn+KT6+3cfF0Y7NzEBEYEHxC0mR5z36eaj2hEo/DrShrlarOWFaR?=
 =?us-ascii?Q?Pns7LcVGneP++0QLrFwBzL99B/ouuavuPDoBJf0ptemfFyP10NL7mph/PYdD?=
 =?us-ascii?Q?MMBpAeaSotb3CnrBxttXO3oW0gEVLmBULKfn6o4oAU29wUmCJt0dJpvXHq+Q?=
 =?us-ascii?Q?D7TF4qoE/IfGjwxEMRahBgtyeaL1O1lOcagPkL0PTDfWCP8lWWuVKLX6Enfd?=
 =?us-ascii?Q?oN8MtQ4E8l4Ju3UnQ74PE0w9dUofIsHZpJ8WTExNqne1Ub8L2xfRYszz/zIk?=
 =?us-ascii?Q?oYPO4bzn+jAltCGAijIVjVwpDv6zWTE9ZQ6An0dV3wp9Uzc0k4S8knFrblKE?=
 =?us-ascii?Q?h3Yob2h3laS4nZVKGNFafxMhHB5HA8mXAKFKXpMu/jDuO8c9fBeC+4MfRKKI?=
 =?us-ascii?Q?fs6y09wWwWEnfbV/R0LAHtFdEmpIJFYj4l/0adU4Bden866aMAUJBjZfIPaG?=
 =?us-ascii?Q?98lPMkqE9axKHa1C7pab9AX1/7H1nyIMfvGdL8vsUX8Ly3DhytH2lhiubtQP?=
 =?us-ascii?Q?on6yoj6MV+GSPhBXGx+MXbZDqcFy2vTTcdWnQRL43H2mGSeFTDrGZsXY2wS5?=
 =?us-ascii?Q?2ziOscYSvRG+6FaA8omLCUqfGX4vbjZUuZk/VhhMTndaDzhonNJPGVLvTF2n?=
 =?us-ascii?Q?LuHIRhby8GZrmT516FoHU1+nFMgb5B99M7QXnpWPV2TuP0a/KA1ZecYXNcb9?=
 =?us-ascii?Q?d03vREdU77FsQzEazP8pQrom1lzJpwbBVnnQqJy952BTvGc5nRWlpOgeWGLI?=
 =?us-ascii?Q?KRlzEKB99WCsaVZdaqzQRSUCgViK2JAJDOovTVssEAU4K8rQ0L0ynpfGvYVR?=
 =?us-ascii?Q?op8x6ctgp9N/HbE9lwuZrvmwKfc/rauHF09fdFp7H/5IaH9Ta4MSCV745nus?=
 =?us-ascii?Q?Njl2GeDXvX8iatxnsQDS2DVoZdL03kU3cnILQFqmiEZzXB1F2BN1q0aNwAUJ?=
 =?us-ascii?Q?2gGq1GaMDMq/HAiXQFQvbVddAJJfgJEP5tqyoTWttPP8M1eb0QTCygFCriM2?=
 =?us-ascii?Q?lNWtXFkeR8JMJgTAeE/jTvKR8wrDUZ+Ts14EAY02NhM2rp3OVNAbVayuWXr3?=
 =?us-ascii?Q?dhZrcQWG1JtCiv5/A1q5PM1fWtJCcoXSkpIV4/avo3k96y12QdiJE79HIHJH?=
 =?us-ascii?Q?z4moZ+L9h/Ei+4IepIs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d949a9c-ee61-405a-7331-08dac78aabb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 04:26:02.6203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dgWsNHVQ7XYVMlhCLVyA3uhfwFB4gxZurXKGPi5Hv2A5T+DxGPKkyBO7VwWBMmGuCzjA1J0ZzjFgq5t7eJba4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6732
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 12:10 PM +0800, "Bjorn Helgaas" <helgaas@kernel.org=
> wrote:
> On Wed, Nov 16, 2022 at 03:34:34AM +0000, Xiaochun XC17 Li wrote:
> > On Sat, Nov 11, 2022 at 07:54:25, "Bjorn Helgaas" <helgaas@kernel.org>
> wrote:
> > > On Tue, Sep 13, 2022 at 09:24:45PM +0800, Xiaochun Lee wrote:
> > > > From: Xiaochun Lee <lixc17@lenovo.com>
> > > >
> > > > When enable VMDs on Intel CPUs, VMD controllers(8086:28c0) be
> > > > recognized by VMD driver and there are many failed messages of BAR
> > > > 13 when scan the bridges and assign IO resource behind it as
> > > > listed below, the bridge wants to get 0x6000 as its IO resource,
> > > > but there is no IO resources on the host bridge.
> > > >
> > > > VMD host bridge resources:
> > > > vmd 0000:64:00.5: PCI host bridge to bus 10000:80 pci_bus 10000:80:
> > > > root bus resource [bus 80-9f] pci_bus 10000:80: root bus resource
> > > > [mem 0xe0000000-0xe1ffffff] pci_bus 10000:80: root bus resource
> > > > [mem 0x24ffff02010-0x24fffffffff 64bit]
> > > >
> > > > Failed messages of BAR#13:
> > > > pci 10000:80:02.0: BAR 13: no space for [io  size 0x1000] pci
> > > > 10000:80:02.0: BAR 13: failed to assign [io  size 0x1000] pci
> > > > 10000:80:03.0: BAR 13: no space for [io  size 0x1000] pci
> > > > 10000:80:03.0: BAR 13: failed to assign [io  size 0x1000]
> > > >
> > > > VMD-enabled root ports use
> > > > Enhanced Configuration Access Mechanism (ECAM) access PCI
> Express
> > > > configuration space, and offer VMD_CFGBAR as base of PCI Express
> > > > configuration space for the bridges behind it. The configuration
> > > > space includes IO resources, but these IO resources are not
> > > > actually used on X86, especially the NVMes as device connected on
> > > > this hot plug bridges, and it can result in BAR#13 assign IO
> > > > resource failed. So we clear IO resources by setting an IO base
> > > > value greater than limit to these bridges. Hence, we can leverage
> > > > kernel parameter "pci=3Dhpiosize=3D0KB" to avoid this failed messag=
es
> show out.
> > > >
> > > > Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
> > >
> > > Some of the discussion here got lost because of email issues.  Lore
> > > has
> > > some:
> > >
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> > > kernel.org%2Fall%2F1663075485-20591-1-git-send-email-
> > >
> lixiaochun.2888%40163.com%2FT%2F%23u&amp;data=3D05%7C01%7Clixc17
> > > %40lenovo.com%7C9cd095ffdb584e492dec08dac440139b%7C5c7d0b28
> bdf
> > >
> 8410caa934df372b16203%7C0%7C0%7C638038076734438158%7CUnknown
> > > %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1
> ha
> > >
> WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DJzWYkIsaEfINofiqo
> > > XyjEh43VjXO3HZw2JLSsmhpUiQ%3D&amp;reserved=3D0,
> > > and patchwork has a v2 with a little more discussion:
> > >
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > > tc
> > > hwork.kernel.org%2Fproject%2Flinux-pci%2Fpatch%2F1664288166-
> 7432-1-
> > > git-send-email-
> > >
> lixiaochun.2888%40163.com%2F&amp;data=3D05%7C01%7Clixc17%40lenovo.
> > >
> com%7C9cd095ffdb584e492dec08dac440139b%7C5c7d0b28bdf8410caa934
> > >
> df372b16203%7C0%7C0%7C638038076734438158%7CUnknown%7CTWFpb
> > >
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> > >
> 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dy%2BtIsepTpyLeoHW6CrgkZz2
> > > tiMjY0TONfK7zNCKXQ90%3D&amp;reserved=3D0
> > >
> > > But the v2 patch doesn't seem to have made it to the mailing lists
> > > or to lore
> > >
> (https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl
> > > or
> > >
> e.kernel.org%2Fall%2F%3Fq%3Df%253Alixc17&amp;data=3D05%7C01%7Clixc1
> > >
> 7%40lenovo.com%7C9cd095ffdb584e492dec08dac440139b%7C5c7d0b28bd
> > >
> f8410caa934df372b16203%7C0%7C0%7C638038076734438158%7CUnknow
> > >
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > >
> aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DzxGz1hZOD2tvQP
> > > EsbxQTzjHwQvXvqeO%2FUd6I9S%2Fj314%3D&amp;reserved=3D0) and I
> don't
> > > apply things until they appear on the mailing list.
> > >
> > > I *would* like to get rid of those "no space" and "failed to assign"
> > > messages.  This is an issue for platforms other than VMD, too.  Just
> > > an FYI that you need to follow up on this if we want make progress.
> >
> > Thanks for your comments, so do you mean we'd better come up with a
> > solution to avoid messages like "no space" and "failed to assign"
> > using a common way, for both VMD and other platforms?
>=20
> I tried to say two separate things:
>=20
> 1) It doesn't seem like a VMD-specific thing, so it would be ideal if the
> solution were generic instead of being VMD-specific.

OK, I'll try to find out a generic approach.

>=20
> 2) Some of your previous patches didn't make it to the mailing list, so w=
e
> couldn't really do anything with them.
>=20
> Bjorn

Actually, the V2 patch didn't following the mailing of V1 patch,
I sent it out separately like the first time for V1 patch, I don't know if =
there
is a mistake in the way I sent the V2 patch. I was wondering if I was going=
 to
send out V2 patches based on the mailing list of V1 patch, if it is yes, I =
must
study how to summit the V2 patch, so would you please correct me?

Xiaochun
