Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1A66E668
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjAQSsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 13:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjAQSeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 13:34:19 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3309A53FB4
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 10:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673978823; x=1705514823;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mLYXfazVSA5M9uvl1VYSmYFHejQG7N1AMoygb7dtFR4=;
  b=k1EYnbUfBwOWCnSTSww+2VhGUBMmAACv4jHmJNHrfzQuuAf2T/5GIPnp
   q3PbQNPTgD2chv8zjTK2+5gbRS0z60MxByt32pdWrRGzQ2zC2xH8OdxjZ
   PFlRonyEK6hPF0qYxuubqSD9hLu5c0tz1hYIfWo0OPw/VhaaWtbGyFqJK
   ZvxQbHHYeRzwcr8gEeU7xqVsFxBAqGXnQnk94D/uVtHnn2gR0gnm6ivHn
   MfR74WAqszTSeM8ybhDyxEHxVE4OtREABBLeXfNdzk3sqEuEB1cdreW8O
   s2aGnhC7F5PmxVXS815F3IEnEqjjEbBsOUSN9MTSV6VMBSWtH7B5kwrpT
   g==;
X-IronPort-AV: E=Sophos;i="5.97,224,1669046400"; 
   d="scan'208";a="220876122"
Received: from mail-mw2nam04lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2023 02:06:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSMQyaXah3ds6qbf/pi+h527czFd0HxZZ6nrDVWha/PGX19n+RH8YqoyssXhJazpsPiECEAXHvGcsb2NIyxJGOGoKedDGXthaM/5KUAq1JDZ0qLfGUNSilJqyz1iTc47ACKDePnDrzudS/KYb7fBbPixBfPndKSmeHaP0eHv0AriGWsL7R5xWlQX8DRHxu9esdlyxYWoN5oJP7B7egMcaWr0IVny1vT66lVCITZq9AQc50Xgonk8ToR05yGDZQAjIsON3e421nhMpb25XCxh0Xs+4djjXUW2CE6n+/SHYE5OcI9qsMc7LlNHqsOG5Y2LwBRwvzg7Rc+nPWCi8a6k7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnWMXm6hDFvGXZzRyaKRsAvo/aUZ7lk2nRVn1rUG5HQ=;
 b=IDquLlHEmRBIuu2CEbXpCjyX/EOha2ZbeeUHui5R0k4EI74HYtyAhzQ2fpsrYNgbsv012R5SYV4NAaWL0tG4MzDhV7bClLT5zpAm1Mnh29vyXdKbl4plykVzJVBuyPMrq+p4pIoBbZkXNfeZZh0ApyEuxGI+V2XD/u8vOX3qPKwsp6e5D428x4REeEhEHW8JOHeAwebZgz3lkVx1BpRi6CAxxUvXfY2gkWmGKhl6i+CvTpv/6+qJiWqZmzBKx7e76mVwVg5TH82hN4PQj1Yo7XpQCJb0KuJI4MHP8yyWgwWZDhFHc7fOONHX3QfeTKlP6e/YX/DB8HpRKpYC4WVd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnWMXm6hDFvGXZzRyaKRsAvo/aUZ7lk2nRVn1rUG5HQ=;
 b=zuviii5xoQUF4nK72VRwPOekkOTMuzHHhDeB5Awhi5CXWJWz4UyFj8iSlFOi37xjabFdb9/+OtMJZPxluuMBRm8mhEpdDCcuGh1nKOOz7aOW7UEKrT66Ul6aysh/YM5lTy7r/atGly315+jktbxLEkgjbzSHqoqP8zConslIsHQ=
Received: from DM6PR04MB6473.namprd04.prod.outlook.com (2603:10b6:5:1ef::23)
 by BN7PR04MB4436.namprd04.prod.outlook.com (2603:10b6:408::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 18:06:30 +0000
Received: from DM6PR04MB6473.namprd04.prod.outlook.com
 ([fe80::27e5:bc1:9b25:d24c]) by DM6PR04MB6473.namprd04.prod.outlook.com
 ([fe80::27e5:bc1:9b25:d24c%7]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 18:06:30 +0000
From:   Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "'hch@lst.de'" <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: RE: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Thread-Topic: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Thread-Index: AQHZKdjydF/vmoLqekqeVIf5E6S3m66iMtgAgABjz9CAABQKgIAAOBFA
Date:   Tue, 17 Jan 2023 18:06:29 +0000
Message-ID: <DM6PR04MB647387CDACE15C3B5767B5FD8BC69@DM6PR04MB6473.namprd04.prod.outlook.com>
References: <DM6PR04MB6473099D6C2AA889D959A11C8BC69@DM6PR04MB6473.namprd04.prod.outlook.com>
 <20230117142257.GA117624@bhelgaas>
In-Reply-To: <20230117142257.GA117624@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6473:EE_|BN7PR04MB4436:EE_
x-ms-office365-filtering-correlation-id: 072d71c0-4f58-4e75-372e-08daf8b58f24
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LATmkXjvqwSQ73VNBGcNuYAJhqGB7N5gyM3u0BGbc3Ary42xLgoKhQPRHrvMfrGpCV4nKTpwQzQ4kDkfwe5l6hXTIv8Rdgt15tPoSQ6IOZE7AQGfcF6wiPJcSdD76LI3VfUM0++JVHxSyXJSWS3RWTtNtMoWCtdrfPA8s1fRlfRUvRryyTjKu3+PqzX/KCEsFbmfgV4uvTokggJ6ygfbYa6hPZE9Y/TC8o5tz6AXx90jyQIQVjW9cU1A0lVFGKQceR8t/OjYE+dhSD5XK8zNnIUa79hRllSXF1EwWS9qTXuNVKRAU77v8eOQRRL+LW4KKko1b8gdnRo94vjCgF9+yQSUNjM4ybQTGKbcDATgwGp8YOpkZLYYgev7ogD84eZeONbeW899bBQrHUKCQEN2rSn+gl8PoiwVmTZhAqOQVLFOJtQfnl6k8Zie0wGaHEcJ39oHEmEdRqyMJVs8+NzLP344sPU/SPcpr7qomBLOS3naoZBKJ2RT/fk7EQO5aZU1OYVJg4lk/Qad3lftEtluOaRS3gmioUmu9xYHJUt5zzBvtcY3uRYyzE3f6LGfDCax1ZGWzvQk9Dc+dfWrpS4mU0GHy+EJ1oAbXuxyYSk6DyPLoqOE8uwXsBOqVbxCMKMYF9aWsnpDC8ho/itlUz945ObaQmzXrxw3saz4vcT9K1LHvEWz50k6xPJAM82tw2CdO01TETbRAHuRzPlUfg2Zx/0y9vSWwexx//KRjYHBanY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6473.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199015)(38070700005)(86362001)(6916009)(66946007)(64756008)(52536014)(8936002)(55016003)(66556008)(8676002)(66446008)(66476007)(2906002)(4326008)(76116006)(82960400001)(83380400001)(5660300002)(33656002)(122000001)(38100700002)(7696005)(71200400001)(316002)(54906003)(966005)(41300700001)(478600001)(9686003)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WCraEq8+wTNIfXG0Pwmc6GuNTKKlLzMS5+EyC53eG3csS3N4D38YsnP7ucKs?=
 =?us-ascii?Q?37UTF5qRJtmw2Ajd4CegXmcwjBY1P57nc8pS/iFzIQuJrVdd5GXto5pqgxL9?=
 =?us-ascii?Q?lEK6ZiRTsztD/6Rsxc6NkqUSE96nSpRmIwlwaIHYhLpPd/iXT4qrOdNk6Qqw?=
 =?us-ascii?Q?NFnHAwOb9qtqcAu0zxQD1HjGOlG0BL+g8ZKVTEUKN0xUDkGjygtpbJTH/Z0U?=
 =?us-ascii?Q?qtt2LbN1YCh3v7UvXsL7cJF47I2Y3F9a1jt4EJAGMe23hwY4xXHiAZTRjEfh?=
 =?us-ascii?Q?74I80b0PsV9jcmpzkIj9k3P0vXUU8wUCnh2e64lVkAak4GESDKGNyUvzYi/M?=
 =?us-ascii?Q?hSVL7UwJQ3R2Zj4CmqBk5IyaLzGVel2GccREpe8lWCepW1dzXU72f9fbcXlZ?=
 =?us-ascii?Q?eDrM+m0ZsHTdRGQUVsHJ5tF61cI/dPEvsJASX++Fi+hRXGHAqfqLM4lB9Vhy?=
 =?us-ascii?Q?bk03My9y6GBpwHdcOA8KGc6Lj7MAHTybsEZ4HUKv1PqNrWGXfzjw1XyfNAby?=
 =?us-ascii?Q?S/VunsIHVgWkXUfHsOiKz6hAo7Yp48/Ej4RlmpgIzo9kCggSVadhjpt7C3FM?=
 =?us-ascii?Q?2bY8fh21JZ/leUBub3UPPoYnzgKPOsbK4t1GXJ6jfgWXbovm5IRQVKpItGa0?=
 =?us-ascii?Q?yBLeMxTUsBbkkVZvJ+EC/7TbFxdxf4RjyoFXG/9nEQMgFn3Ny/dWveGkxGTP?=
 =?us-ascii?Q?UePweovfaWUaIaJlqnci4ix1CB2ChmlvGKDh4JD5FJx1e8cImuu/nDOCd6AG?=
 =?us-ascii?Q?dUR9/QwtQxzJM0SBvmcARhE70TdKZSSScuGtIr8s3HfsjeyRucIEUQNFpw3x?=
 =?us-ascii?Q?TibENHa7AIneKQO7LBD0eRvvBOr0SEnZh0vhc4t6iEIi7K1BGE6oagia/Saa?=
 =?us-ascii?Q?3LnEvBrnUdSCxpCocDOoEYyTXKBUTLy170auvS0D06CsDMtTMkHy9HtpuCXo?=
 =?us-ascii?Q?pA4zmfJr5FP9EgO9j+7dUbkd1qUnDpqCfvcckd9pIhOy7ZLRG57F86oGvUtn?=
 =?us-ascii?Q?ilyXAqKfVIUPMefSDR6gmrDGwOuA5Kc5nCoMhJimS4aAyjXTUUpOyYUrRD54?=
 =?us-ascii?Q?vpstBm5BHeXjVdqHc/JGK8/ySwNewwwXvETZ5b6vqkctPU2GbImFOodttT3u?=
 =?us-ascii?Q?DmQ0pUtzrWK2C5fxwV5xNeQSj3V3ZmQzZsUwi2WAUcjDKm0OBwBN5F9YBjwm?=
 =?us-ascii?Q?dXFxS57uCPeBZSa0/ookugSoiZ4rR4YK0ZM9j0fK86LGCpGdwURgkufCEPGG?=
 =?us-ascii?Q?QKgsKdcwmLSTqxtklSzAkZHRR4nRcBVUhSoXjZRRnmSQieuJz4c4PLmGZzeM?=
 =?us-ascii?Q?w4fjA/6J+HVVyvKVLa80ShHHaX2FP3tqcfiXhBd4/7DqRne6VQbraHcYpr3i?=
 =?us-ascii?Q?aFpBTWXAWTzSOfxv3w5uETt2DO4MKfwzqhlT1/SkXSavt9Mi44wpIx0xfal0?=
 =?us-ascii?Q?1HKHtrz4NqtR+IxWjagvUFtQjkVWGbCdErReFObvkUFxgoZSTKAoWAPen6Vc?=
 =?us-ascii?Q?b/l+RAeVNzWyj3+e324/q2Sywwsdx/A22CZc0gipTfMpZb9Ds/Ugda/pAUno?=
 =?us-ascii?Q?IgMEH/Xguhp8Ft0aZQFqslaMeLTYPK/YjvGStndVvSop9YfPFoId0B4CEfyw?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kjPo4wRN0vzIZPjD7Sb8myW6cgKBFv8FmuRKnp38JFr8LSbzvA3uG+YTMo85SWHv1/GGxhTOFY7ixUkYtn9YZvS4R2wGJwxZpzhvjnwPcjQM8bsNBNSHG+echJdGabYbsW+uCqKTgRvciY1qcPuaQNLw21pf6w6ZZpYmrMLAGIt/dnDdkXIFy5Iq15kQXxnzQpz88pCYd2V/3zFxPJ7r0VAPDEVD1lKETY8KRxTg8KNjltr+fJ20jKG1qthFjxhUdgfwb3etUbU/53NH61nWcP7i/DU5lIWJFuKnArclY0Y8HXtNe0tO7xo1owFpTkzA4Tr9KSzFdRRV0Vaa3Docw/bi7Qtx/diWcGPqDEQdo9T0ER/GC6RpPLex+GsO83zdpQyYnrzcT5ajgkOa4lv6oNtnpOm9PwvM3VTXS7YK+uXX5H90ls8+/X5Y+1zvUufViNqWTlE2qh4SHnn3fxlOaz8uA7sGQlZJwSGAdQJ3JlJDEmAxH/B1z97dzNjGlRB2Efehy/lqSS5Nhip2Q5+4GodSWi3ymzm18erQb8HfyXRM2Jv0KLXIeQ/nWi7VkSe6DKP+GHVu1pJqNhrHgMpfgqKBzWn74dd5nFMGQ+tfBgOW46enCYe2xZz12pQfMHLvHIOkKZCa05LCvzU0KPFFqWlDFb0+XzmYu7lw2quojrGC03EAiqtqoYAjvTwYL9GqZjP7OI0f6CSSf4Yg7pnUYHbFPj+SkOZufn/8wstrcEoCBEDFKXdK9H5xZY+H4te6Nx8Gt41VfmkBSrVajZXKg29AbzEn4pe6+KbXBvkliHdPHeAqncms9RNsQgPAG3EgdVKjuBSZlYW6xpOc1jbQn52W/kxreTCpPRBYrddVsdYKf7Jb7MZHv0kytf0lPZBi0aRMPb23netDK5qP42jSSg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6473.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072d71c0-4f58-4e75-372e-08daf8b58f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 18:06:30.0474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fG9uwnRR8AL2aSU7PWlY+t10VlvhViBSn03kBjlypAujQOgjX3JOYWdgvskmJYyW8dQ1co8hwANb5PkPUz5ZuUJd16iVZohADFFE8Uvz5uM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4436
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>From: Bjorn Helgaas <helgaas@kernel.org>=20
>Sent: Tuesday, January 17, 2023 4:23 PM
>To: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
>Cc: 'hch@lst.de' <hch@lst.de>; linux-pci@vger.kernel.org; bhelgaas@google.=
com; Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
>Subject: Re: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN7=
30 WD SSD

>[+cc Rajat]

>On Tue, Jan 17, 2023 at 01:20:28PM +0000, Alexey Bogoslavsky wrote:
>> >From: 'hch@lst.de' <hch@lst.de>
>> >On Mon, Jan 16, 2023 at 06:32:54PM +0000, Alexey Bogoslavsky wrote:
>> >> From: Alexey Bogoslavsky <mailto:Alexey.Bogoslavsky@wdc.com>
>> >>
>> >> A bug was found in SN730 WD SSD that causes occasional false AER repo=
rting
>> >> of correctable errors. While functionally harmless, this causes error
>> >> messages to appear in the system log (dmesg) which, in turn, causes
>> >> problems in automated platform validation tests.

>I don't think automated test problems warrant an OS change to suppress
>warnings.  Those are internal tests where you can automatically ignore
>warnings you don't care about.

>> >> Since the issue can not
>> >> be fixed by FW, customers asked for correctable error reporting to be
>> >> quirked out in the kernel for this particular device.

>Customer complaints are a little more of an issue.  But let's clarify
>what's happening here.  You mention "false AER reporting," and I want
>to understand that better.  I guess you mean that SN730 logs a
>correctable error and generates an ERR_COR message when no error
>actually occurred?
Exactly

>I hesitate to turn off correctable error reporting completely because
>that information is useful for monitoring overall system health.  But
>there are two things I think we could do:

>  - Reformat the correctable error messages so they are obviously
>    different from uncorrectable errors and indicate that these have
>    been automatically corrected, and
We've had long and tiresome discussions with the customers using this
specific device in their design trying to convince them to just ignore
the messages, but they wouldn't budge
>  - Possibly rate-limit them on a per-device basis, e.g., something
>    like https://lore.kernel.org/r/20230103165548.570377-1-rajat.khandelwa=
l@linux.intel.com
The thing is on this device correctable PCI errors can never be trusted. So=
 reporting
them in any format or at any rate makes little sense as one can never assum=
e they're real.
Also, the loss of potential real error notifications is something the custo=
mers seem
to be OK with, given the pros and cons.

>If we do end up having to turn off reporting completely, I would log a
>note that we're doing that so we know we're giving up something and
>there may be legitimate errors that we will never see.
You mean, print a warning message the first time such error is reported by =
the device
and ignore all additional ERR_COR messages? This seems like a fine idea, I =
would
definitely be willing to implement it

>> >> The patch was manually verified. It was checked that correctable erro=
rs
>> >> are still detected but ignored for the target device (SN730), and are=
 both
>> >> detected and reported for devices not affected by this quirk.
>> >>
>> >> Signed-off-by: Alexey Bogoslavsky mailto:alexey.bogoslavsky@wdc.com

>Check the history and use the same format here, i.e.,

>  Alexey Bogoslavsky <alexey.bogoslavsky@wdc.com>

>(Also for the From: line inserted at the top.)
Sorry about that, will fix
> >> ---
> >>  drivers/pci/pcie/aer.c  | 3 +++
> >>  drivers/pci/quirks.c    | 6 ++++++
> >>  include/linux/pci.h     | 1 +
> >>  include/linux/pci_ids.h | 4 ++++
> >>  4 files changed, 14 insertions(+)
> >>
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index d7ee79d7b192..5cc24d28b76d 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -721,6 +721,9 @@ void aer_print_error(struct pci_dev *dev, struct a=
er_err_info *info)
> >>               goto out;
> >>       }
> >>
> >> +     if ((info->severity =3D=3D AER_CORRECTABLE) && dev->ignore_corre=
ctable_errors)
>
> >No need for the inner braces.
> Will fix
>
> >> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_WESTERN_DIGITAL, PCI_DEVICE_ID_=
WESTERN_DIGITAL_SN730, wd_ignore_correctable_errors);
>
> >Overly long line.  Also wd_ seems like an odd prefix, I'd do pci_
> instead.
> Will fix both, thanks
> >But overall I'm not really sure it's worth adding code just to surpress
> >a harmless warning.
> This is, of course, problematic. We're only resorting to this option afte=
r we've tried pretty much everything else
