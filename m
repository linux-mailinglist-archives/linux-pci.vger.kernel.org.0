Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3BA7A3F12
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 03:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjIRBCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Sep 2023 21:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjIRBC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Sep 2023 21:02:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C73109
        for <linux-pci@vger.kernel.org>; Sun, 17 Sep 2023 18:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5mK4FoEcVHLC4icmb+n000Djs+9kobCbf3aYWmTD6hTwUoKAPo4ygcARLpMxvDi7pZnwo2IsatKBrmmDMHjJv/Q6imvN+HL+NiGHAA4FaceJdjeXAgGatIXOSzkuHljTRIcra9T82oZs561S/rUm6jNolAo97Mn5mvEXvSov/Z6reGlfBXBokz4ANGneZ/wNV1iZC0WsomqVHypj2CXf0EsxcpOLdDZcMMuj3s77aLeGRQRGz2aTmUSJIR6VM/H3H6FiHIHlB1yI0MdW3BzQXHk7WfQY/oDW92OdTQu6IJXgxRQsuNaROJJkLzZ2M4HQ43tMerpkr4d0AQUxqGazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tqc+0s93Rco+2lH0GCaO69acL2qrKIGaO8XhfKhuFZ0=;
 b=ipmak1lwiBo8M51lPkwYGiFh1R8D3cWdF5Na6H8Xui4lQxlvaHjdWvH73i7feDpIr1cMH9+Qs7IfTBwzxeH8qBqE1x87Jj1iJ0zn8pR/Rd3LIer4pOtPKtuAB+ghP3lUd+jOaPhh0xMubS8jASWbXzDGJSBEqK9i9iKqNN8xST0Q/qaO55CazrVNCNqj03OSge5X7JCC8hv5auwg7EnLYfQEk1fa/qwu/J4tklYNu3HU9DIXGiYe9nm5l5K1l08OZY264LfE6WdnpcIxKv5DzpQR6UAmy6XUa+hnmF8rm2KGL4IG80vAyehP5qFHtexTCYsNTIXQtmbwY0FqGrj9hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqc+0s93Rco+2lH0GCaO69acL2qrKIGaO8XhfKhuFZ0=;
 b=dOWLSGhex9tLR19xX4IA6AN6TvR+N/ZXAa/4iDzarE/bFZTO+n0XbsLhfx14FYG8bmBoh8XdR862lelPJDHEQNmCUUARnQqyCY96l01vy0uE0CCp4tgggBRPFREoIH6okoVlOj54oadRE3CW3vuSj/WlMvy0J6E/zyq0fO025uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Mon, 18 Sep 2023 01:02:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::96b:b6f7:193d:82d5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::96b:b6f7:193d:82d5%2]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 01:02:19 +0000
Message-ID: <6be70596-15e5-473d-9722-2085ef539601@amd.com>
Date:   Sun, 17 Sep 2023 20:02:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <20230917214015.GA171862@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230917214015.GA171862@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: e92fff71-03ec-485f-0b1a-08dbb7e2e833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R810M9nU/tVviNG+0bwqywbwch6u3nEGb70Aogh89xHjgrWPFeH/Ddq8m0Za5Yth3+Dw48+E8kGQEKkjgk2NAIUEdsGS3NPHvpjiZdLPbKwKn0eTN1nc9iL9w013FMUcCRaM9NjNJbW6V64Y8yWfGSzueguiNejiL2945nXEMRsNQgO3Zh8FZClwQ/iFVuqVRnnDQxXAcd0BoUBodz1SdCi2/D9U6baOCVZvh4mPOL0I9Jp8h+QBDmCMb5EYxG3LJAavMB7TufJnlTrRz4rHYoIBLMxCZeIqf6dQlwSgBrBI+48iN3uzCLNlPTIP1cJ3rndgsywQWOKgcBb4r2CTUG9e97ugpi/WtXnH3C2o+AiVB1aWCw9lyYAxJ95yoaSfxaYBnF0fTkbGVVVqM6j4uDEo4ZlBHwReorcH+4OvyYVpBRRzhpSywJCx7w3npHnCf1lppix66q4kdPq0SeoNq8NoILQWR/tsSe2BW28Hl1PTChAkt0qQ9q7mkCbfxmSBzPrJEBvMAk151+i19361yr84/FpxQHjQg7V/KSdJ3TtyZYQkzAxOcnla00nZLaE/OXg3iEqw/PsoXKlxdH5vOVKFueeyClWhDsmpPaqQqqmlbfzs1ENt+XrXwA3SmwX/wZY/qWizkNplMBtsTBYE6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(1800799009)(186009)(451199024)(26005)(2616005)(8936002)(8676002)(4326008)(2906002)(36756003)(31696002)(5660300002)(44832011)(86362001)(53546011)(6506007)(6486002)(478600001)(31686004)(6666004)(316002)(54906003)(6512007)(110136005)(66946007)(41300700001)(38100700002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2JDMFNNYmZObzhsUmhxTmxsVGZxdGovajV0bUVQVEt4NC9zd0g0ZFF2SGpr?=
 =?utf-8?B?V2I2VFZVM1NmSTRRTFNaVGhMdCsvVXVTKzVvcG51ODR1YXNIV3VYclQ0WlA0?=
 =?utf-8?B?TGZNQUwxWXl3QkxtUnlLSFVDNG5sT3BOR1NzNFhwTUxJMFFsdmR3d3UxZXY1?=
 =?utf-8?B?cFg5M3YyOUpVbThkd1FTY3YzU3JLa0d0VThiV3JtZW5IcWxXVzB6azd3eWNL?=
 =?utf-8?B?aGYrNkUzL3RwcnJ3Ly96V1hFSW9aTUZaSFZENUxCZlFWQnNycjZIUzBsTFl0?=
 =?utf-8?B?Z1owRWJ3dEdTV3diU2ZhN2Vmc3NNL2VucGIzTFJFQXpIazZ5Q3IrbGZHOENO?=
 =?utf-8?B?VHJtVkZISWVzbXIyM29xKzdNUCtMamtoellqdEdEcUJ1NkVETjNwRGxGU3pn?=
 =?utf-8?B?QnBhUEFFcitGRjZ0MUpZVTY5TzNTUE56SzRrb3A0RXlQS0ZpM1lvOGxLU2No?=
 =?utf-8?B?ZktTdGtHa1hnQ3k4S002UERub3NHZi9QckJXdXJvaGc1ZUJKWjhYZ0k2NDVC?=
 =?utf-8?B?T3FmbWM2Sk9qZlN5OWVOQ0lnd2dmL01DaXJ0SFVUQTByRG45MGtucFdIaEFu?=
 =?utf-8?B?MzZHR2I5UHg2TVJQRVRWY05zakNvVlMwRnp4bFpxSkp4SGZ6VnRyUXAzcVAr?=
 =?utf-8?B?ZklWVFVvUmtVTXFwOUxWcUlRNGs0MFh3aFhvQXpydVNHRnNUYVowSXJHRkhz?=
 =?utf-8?B?b1I5WEdESWhjc1BNNHZ1QlpMMnlEbnRuSHpXN0VRaytFNTUxbUxOakE1R0ZO?=
 =?utf-8?B?ZjZUY3RocFhvV0o0ck8wb3ZUaEVmUEdpLzl1WllBZmg2bDhtcFFUdWpkeXkz?=
 =?utf-8?B?YU82Y3E5NmxPdVJXQTZrM1pOMXpFTVY5SXY4a3lrVC8vM3UyemhWdC9TYTY3?=
 =?utf-8?B?eFY2QTZ1ckt2R3NmRUZBdURndmJqVGN5K2M1QktHc3VBNFdqYzhNeXFxOE5n?=
 =?utf-8?B?cmx3VTNQdWlEUituMW5uSVRMNkJZcmVJQXlQQ003OU9nRXVZZ1R0QjV5Tkc3?=
 =?utf-8?B?V0Z1cDRpeTRpQzQwc3I2TUd6NzJsUVlxQTJReDJDeHJkZW1zUDRWQ1Bua1Fw?=
 =?utf-8?B?K2xBRllmZEdkc3JuZGFCTmxCS3lHRlQwMEErOFVnREcwVGlXbzQxREFvTTNQ?=
 =?utf-8?B?MnovTHlkbUhvYjdVWXlseXA1MTdCd1hJWDJjQWxlbGl0ZlJiUERWUDNCdzlG?=
 =?utf-8?B?QXphT2tzTmE0NlFDcXFGbXlZNmNERFRJZzZjUlk0VUFUcXFtUklRME8rNmYv?=
 =?utf-8?B?d1I3NFQycTBFMEpxZHgrNFFkME84bmhaVmpQRWIwWWd0M0ZxdXZFd05XNW1k?=
 =?utf-8?B?SFBVTkM1UGFTWVMrWjdTWmZyZ3B4WVhYUEJVei9yMUM2UW42T3BJYU9VTmdO?=
 =?utf-8?B?dTdJcE9BM2dnekNMS3VISnVXOGhtbzlPZ1VHZHBRQ2tXZm93UnRwczREKzJv?=
 =?utf-8?B?VFhOWFU2anNURHMxcTdXSUtJWlpLOUg0eGhqTWdVVG9FTGQvRHB4aEQxeXI2?=
 =?utf-8?B?L1RGYURwR3NvdmNpTlF6U0l2U00vYm41SjlMeVphYkpuVVlNQm9nREVhUjd6?=
 =?utf-8?B?UFdrRlF1U1A2YnNxbmx0TDZoYnFJSllacWNtcWhYSnd4eDJNeUxJaGNkTmsr?=
 =?utf-8?B?MUVQNkNnOUR5cTZJOUcvcXE1YmVsSk91elJwRXV6YS9RNXN1Wk83elprTURO?=
 =?utf-8?B?ZGVpNE5ua3BNQW41VXVlQm4xRUtBNUE3UW1XM3FBTTRMTXAwV3oxRkNtYksw?=
 =?utf-8?B?OEdJNVJWblhJWVJLdWlpUlRudU5HTDdGbTJ0Sk9wWkhzMVFpSWlpUU1KVzdF?=
 =?utf-8?B?L05EL25PakRyVUgyRWZDa2x2QmVsczBqSmUvbCtZS0VYM090amRzYldCUHhk?=
 =?utf-8?B?UHI3Z3VHLzBJR1ErVmhQVmdRMnVHNWg2RmMrV0JsQnE1TU5ZZWV5NXdkMmJB?=
 =?utf-8?B?a1REb21HOFU1dDUxMEk3RFdkeStjNFR3ZFJENGE0WFliaFVjWFIxdnJacHZ3?=
 =?utf-8?B?T3FZQjJTdFN4ZWtnVWZYYjd1T3k4akZKd09CYkJGdmF1TURTd0pSU0hPSG5B?=
 =?utf-8?B?TTZPMkpNUURzQTlKY0FMVGo4WUVyOUFBc3k5Z0kvS0ZIQzJYMUQ2S0pvN0lW?=
 =?utf-8?Q?Jrzv5MgYV7PQKOs73etDMMPQ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92fff71-03ec-485f-0b1a-08dbb7e2e833
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 01:02:19.1052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qkxAvUetulAC3p53BQNpqxeL5l1Xx/Nfvdr1w9CfM0fiHTdwTjysfKYMQileLiCw14DVca9ghlwrdMIzIVjPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/17/2023 16:40, Bjorn Helgaas wrote:
>> The "pcie_find_root_port(child) != pdev" check is always false:
> 
> If we were using pci_walk_bus() and only looking at devices below
> pdev, I would agree, but since we're using pci_get_class(), which
> searches all PCI devices in the system, I'm confused about why it
> would always be false.
> 
> I don't really see the point of checking for USB4, because the commit
> log doesn't say anything about why this would be specific to USB4.
> 
> I know Mario has mentioned something about how "internal interrupt
> routing works with the USB4 controller connected to this root port,"
> but I don't understand what that means.
> 
> Is the USB4 controller integrated into the Root Port?  Or is this
> interrupt routed via some non-PCIe mechanism?  If the USB4 controller
> is connected via standard PCIe, I don't see why the issue sould be
> specific to USB4.

It's the latter.  When the PMC has the SoC in hardware sleep the 
interrupt routing works differently.

That's where this bug stems from.

> 
> I could believe that BIOS configures the Root Port differently based
> on whether the downstream device is USB4, but I haven't heard anything
> about that.
> 
> Bjorn
Nothing along these lines.
