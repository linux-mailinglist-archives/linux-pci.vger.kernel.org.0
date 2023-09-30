Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F9D7B3D26
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 02:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjI3AL4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 20:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3ALz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 20:11:55 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2095.outbound.protection.outlook.com [40.107.96.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D59AC;
        Fri, 29 Sep 2023 17:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/EVstZrWqFjmc/ljjSdqIS6ot04BYSZ/G1G0MRpTgUwRbbO0VWhy6g+MEuCh3YK5er1dXQeExImOZlg/oEYUcYEOS7V7etfEhu5YVrW7zElmJV1X+/LulPTPUC2n5KxrvtU4dRLc8yrfsgiETMD8pcvhZZ8kK1jZMNE1fUDyQ50LCfIClkO7nVOHfuJbE8yA392oR7J/v4k5Z9W0D/XrIAgtKDoc2KFLUWZmSoHpxOV9K7UrslS8aRWUqRiXCEVcuU50pbqfsjq8XVeU3dd7bgx5j8MQI0FKQF6DKIMvWvZf11hjwgBhLGt+hI4oGRWyzbBKMqvXDscyGndKoLZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3ZBnqPsmIQkIvBFZ7uVdUS2mck0WDms3qyUARgh7ck=;
 b=UMHO8+3K89+DLzDy2kTE7Sc6XICIH9hD6YDgw3ILobKp2edYw13H55Z9t5+I0U7ZYrAgoC843Qbq07P/oK9P0tca3MDpjP5HUEcYEVSft0gtSSA53yjA5M9Scud1hhR8v4aveU2JYLlcfMV3mbbdlf3fn5TLitiW/RvfzqhdcHKoDhMQECUHFNtl9GtQeY9lV9cx2Luyi1WUvgwXzRfxLa5x9cirHYVRqlZFluKUkrcr8uBoGDuQQwem9h50Sq6rPwEVw4+H70AorHGit2kUmlWLYs08Szmt3XF8aMvgY/mnvfu4Xg38Tho3gVSijVkuesVuRdA3YGYuKdMCUccgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3ZBnqPsmIQkIvBFZ7uVdUS2mck0WDms3qyUARgh7ck=;
 b=Ap6AaYT+gh3jreUghgegdcb2G7uq06q22H6CiqMok9mgtBUToQ4ZHvxLmypzhVSwd74tIaZQGcTDXllue+3P48hlHsFBliq/p5We36VMA3pjQHfWNtiH1uDcAD6Pah0dQjGwjD2zbbbC/cFUWR8uZpeGgtTZZ4UbZr9BZrs6WI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 MW4PR01MB6433.prod.exchangelabs.com (2603:10b6:303:66::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.30; Sat, 30 Sep 2023 00:11:49 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e%4]) with mapi id 15.20.6813.017; Sat, 30 Sep 2023
 00:11:49 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: Re: [PATCH] PCI: hotplug: Add extension driver for Ampere Altra
 hotplug LED control
In-Reply-To: <20230929203234.GA552475@bhelgaas>
References: <20230929203234.GA552475@bhelgaas>
Date:   Fri, 29 Sep 2023 17:11:47 -0700
Message-ID: <86a5t4r03g.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::12) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|MW4PR01MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: db8373d7-7125-42df-2c27-08dbc149d75c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhjVlFwsWgq4XhCY9421Rr5HAYkIWyWyYWZrnV3oWR3iyVOxH1PQWS34uczO1h9LaCVOiZpLOVz9ENH5km1GVIPztKQrZF/5Kxa4eSAZFREn1B17Q7lqzklasXvODMpSOV0Kpoz24EgsO9M6cjHnuaYeDrR5erl/nkdcTfcfKv9OeZU/4qEjvqlYLR6Jz60fLW6L160kj9OOAvrYDA8D6O13esgKMnc90NoBwpOJRPd5g6Sh+7O4YXuIWoyiu+ING4B83/5ARJLhZMTyOwMGb8Cr26X7DYLVyQMHQoSXvwrFeQTGwiws7+6NaXEEjzDaR+GF7pjAInF2QU031SrD3/EMkD81FbogZ2OCkPpvdxoODjgtZOYNemCafXe7A3pB8tqlSUxsLRi/kk/ihZm13mpN7kb0aN4XHuKVT7uN05rA87UqYr1/6YfnRfV4ZOen1+vLYTY5SHAFMnQkfOkhNPdZLZJaQBQWCD5+8aQ48AXfIEGcNQVQELebTbPpHfWgbE7GxnxN+x+mFbAanK2T09Gr4cGKp0Gv5FZRJwcldWXBTZ8ND+MuLpOKAtZgPwtUWu4p3qJ70Q1/gFvuOThkbJiXG+7/AwlCRu0zbghmGSslqCZgplm3juL3xgfn9kKY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39850400004)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66556008)(38350700002)(54906003)(86362001)(316002)(26005)(478600001)(2906002)(6512007)(52116002)(107886003)(83380400001)(66946007)(6486002)(66476007)(41300700001)(38100700002)(8676002)(6506007)(5660300002)(53546011)(4326008)(8936002)(110136005)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBBRFhveDRPRmdIRU1kNGdYYU1kVXhTTW8rSlZwbFhRaXJyM1IyNVI5cEJW?=
 =?utf-8?B?dHk3RnpvRS9rR2JjQS9TZ1JvQnJZM2xqS3dBRWdXZjMxa2JSWUxER20vaWFZ?=
 =?utf-8?B?bE1ZQ0FJYjBnWEdnVmoyVzk2dG4xUjdYYXFOeTFPWkxxWENzZmtXYzByQkpp?=
 =?utf-8?B?RUlsckFMRzlTNXk3b3VYbWZ6R0I2UmJCV0U4SlVpVmVmbDVQU0dVZHZzbTF3?=
 =?utf-8?B?c25XajVmemRkNXNlakE3OUhpbzdIdEFIbm5HaEF6cEl4MnQ4V2lrTFR0cnpY?=
 =?utf-8?B?bWNiSHFuME5FdU5oaHRjK3k5K05lYW5ab2p4aUhjdG5UdEJ4NTdudzh3c1FI?=
 =?utf-8?B?MDJwbFV1VklHS04xV2duaTlRWVJZcVVMM0ZWV0xwQjhQVzd6Nm40MTlkWVhj?=
 =?utf-8?B?d21OV0tCaVR2V1lqcU5SZS8zQkJEMmwyOFJraHlrcEhZeklneGhwQVJNcDRC?=
 =?utf-8?B?OWNHNG80Y041Wml1MC8vUWVTSmhGK1QrSjlZbHlPdW8zY3VTMkllWVQ4bllR?=
 =?utf-8?B?Y05vbElDSTlCSyszQzYwaTUzTWxqckNKNS8wM1FIZC9Ob1BuVFI0NkFiN29F?=
 =?utf-8?B?QlBXaGRXRVNUTXJzTDRldFlNSk15ZEFhc3F2NHBHVEtFaXVVNDRWbHpQeW54?=
 =?utf-8?B?UGt1YmpoQ1VBdjA4dVZwZmhQTUZsbzBOcnJ0OXl2OFRyN2s1V01hTTVCUGJ5?=
 =?utf-8?B?Z2xlWmZta2loMnQvT2JVdVNOZ25DMStTRUhoampUWnlHZko2Ky9mUTE0bmtj?=
 =?utf-8?B?Wm5DSGNpOU9XT3VzVWRHdSt2SG1NbGRmVW13c1Jjb3N4dlBBc3Z6eVJnYk5n?=
 =?utf-8?B?Zjd5VzYyNTlRbW5QZkQwSlNZNEpWazhMMk5lVHhLMGtPZ1I1dDg0T2V1amtF?=
 =?utf-8?B?T1V1SFN5eXZTYW1PKzRhWEVDNytVMVJ1UFNmT2lZMnBoWDM5MGk5TGk1ODBE?=
 =?utf-8?B?TzhZUGw3TWQwbDFYUFJNNFZCMVBoNDBhcTZTYWZmMUs0SnVhN3ZHMXJqVzU3?=
 =?utf-8?B?eUxVTFN6eXRhRlRwUm9qOFlqN1owNHNiNEZWSS9IbGpFcnVrSDhoOE16WHhD?=
 =?utf-8?B?eStSaGRDWGwwV25OKy9tQnJiQW4yRDNRSHdiNGVUS3hWN1huWWd0N0RJTmhI?=
 =?utf-8?B?eE9ocSt3aWtVR203Rk0wZUY3bkV1ZHU5NkhBRG41Z3gzY3M0VGhrV1lBOXgv?=
 =?utf-8?B?SlRTK1ZUcE9PaVo0eHFpUjlyK215UTd6b29DMGIvT3ptOEIxRHBSM1RpTEZp?=
 =?utf-8?B?eGNtbTV0T1NWRnU4Q1d5NUlORnJqNlkzZmpYR0J6VHRlbnl4UXhMNExMZ0h5?=
 =?utf-8?B?SjFpVTRHb3NRcDJSRm1GSXBFTTVJTE9VbVlSSVRuZi9SZitucEZFM0h4d29t?=
 =?utf-8?B?alV2dk5neFBIeXBQQmd6Y0VRQUtEb3B6OTMvdUNBVDNyZVFrT3pxcEdKNXM1?=
 =?utf-8?B?Zys2emhPcVkwZHovdFpReGdXUXl1ZnNqVzh3TGFVOTFvQlVHeGRNY2tyM3VI?=
 =?utf-8?B?aEd0czdjZFUzN3pIZjl1a2xpa2xGZ1p4Ym5xWG84UThnZ1JlTW5LYWhVNmlh?=
 =?utf-8?B?NDhneXY2Y21yejZrUDgxamtoM2M5NG42V0J4b0ZqczNWdVFnVWx5ZzkrZDU4?=
 =?utf-8?B?NFA1TkFadjE0THRHNCtaRWZueFRkY0NNMklNRnpGNGJMWTJCTVpOM3VBRUMx?=
 =?utf-8?B?WnBEK3JFSUF3QURpV3VpZEZqQ0REbDA5dFlKVWsxdG9qZURqR1l0L3dmNHhJ?=
 =?utf-8?B?OU9YQTZ3V0dMNUk3KzdPMGhYMXg3ZUtOaFhkOTdPV3RodExMT2MwS1hjaExM?=
 =?utf-8?B?azdVeTJ4bldYZEZUTnpjWVpadm9aS3pFTVZVKzlEeXNMbDNKbGVTRnljSFhG?=
 =?utf-8?B?eHhYUEtvaGpRYnljdFlHWjlPYWd1SGo5Si81VlVqV082OG1OektMNUR3VFVj?=
 =?utf-8?B?cWljZHNlbGc3OTZCSVU1R3Z6STAzUlorRmlwZ3pHL1NCYVRBRjUrRkpVYmNY?=
 =?utf-8?B?Zzd1QVhUVjJ4Y1ZwZWJjYjcrUDd2dkVxMEFva2lvVFl0ZEU2dld5L1JZNjZQ?=
 =?utf-8?B?NDlLNkNNbXZ6ZDJrTlJ3SnB2ZVJ4bW5mWWVRVUxFUGdaRkJpVFZBTFlocGQ1?=
 =?utf-8?B?TkdOTjNxRHdDcU1lcFRTZ2M2RW0yQXMrdDhHbEVULys5NUNFZGo0QXVJalZh?=
 =?utf-8?Q?FfEUNKMnV+ENmdloOHZT3jc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8373d7-7125-42df-2c27-08dbc149d75c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 00:11:49.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLmi3y5nwGgqmlp31TlpX2VPUOwr/GAOMmBSnUxwyzWmq2I94cXyHrM0NRAi7K/x6Vcvco/IHLXqr3qKDUAv5kgvPOL1AjnwXxY6HeWYhCgTK3MjwNOvOrDqMe8jZUno
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6433
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Sep 29, 2023 at 09:06:02PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Sep 28, 2023 at 5:47=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
>> > On Wed, Sep 27, 2023 at 01:23:47PM -0700, D Scott Phillips wrote:
>> > > On Ampere Altra, PCIe hotplug is handled through ACPI. A side interf=
ace is
>> > > also present to request system firmware control of attention LEDs. A=
dd an
>> > > ACPI PCI Hotplug companion driver to support attention LED control.
>
>> > > +static int __init acpiphp_ampere_altra_init(void)
>> > > +{
>> > > +     struct fwnode_handle *fwnode;
>> > > +     acpi_handle leds_handle =3D NULL;
>> > > +     struct acpi_device *leds;
>> > > +     acpi_status status;
>> > > +     int ret;
>> > > +
>> > > +     status =3D acpi_get_devices("AMPC0008", get_acpi_handle, NULL,
>> > > +                               &leds_handle);
>> >
>> > Rafael, can you comment on whether we should use acpi_get_devices(),
>> > acpi_bus_register_driver(), acpi_acpi_scan_add_handler(), or something
>> > else here?
>>=20
>> Personally, I would go for a platform driver, because the ACPI core
>> should create a platform device for this object.
>>=20
>> acpi_get_devices() carries out a namespace walk that is costly and
>> entirely avoidable.
>>=20
>> >  I try to avoid pci_get_device() because it subverts the
>> > driver model (no hotplug support, no driver/device binding).
>> >
>> > I see Documentation/driver-api/acpi/scan_handlers.rst, but I'm not
>> > clear on when to use acpi_bus_register_driver() vs
>>=20
>> Never.
>>=20
>> > acpi_acpi_scan_add_handler().
>>=20
>> When you don't want the ACPI core to create a platform device for your
>> ACPI device object.  There are cases like that, but they are rare.
>
> Ah, so none of the above (not acpi_get_devices(),
> acpi_bus_register_driver(), OR acpi_acpi_scan_add_handler()).
>
> IIUC, what you propose would look something like this:
>
>   static u32 led_service_id[4];
>
>   static int altra_led_probe(struct platform_device *pdev)
>   {
>     struct fwnode_handle *fwnode =3D dev_fwnode(&pdev->dev);
>
>     fwnode_property_read_u32_array(fwnode, "uuid", led_service_id, 4);
>   }
>
>   static const struct acpi_device_id altra_led_ids[] =3D {
>     {"AMPC0008", 0}, {}
>   };
>   MODULE_DEVICE_TABLE(acpi, altra_led_ids);
>
>   static struct platform_driver altra_led_driver =3D {
>     .driver =3D {
>       .acpi_match_table =3D altra_led_ids,
>     },
>     .probe =3D altra_led_probe,
>   };
>   module_platform_driver(altra_led_driver);

Ok, thanks Bjorn & Rafael, will do.
