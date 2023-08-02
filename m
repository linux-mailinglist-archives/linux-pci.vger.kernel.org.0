Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49B76CFBC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjHBOLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 10:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjHBOLJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 10:11:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3180F7;
        Wed,  2 Aug 2023 07:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqZ4jpAUdYLNMnyiha7uqHU2yGlb78grL3IlU+p3OwjRGl8DobveDHR0qV/cptcQ53W5+uenJTu5A77Cj7fxYHvA4YXi7OgY7qGbYO1D+hSvxtNLROyeJmS+N5e9wdSsWslNZaspFfoXoqMAI3w+92J44jpsmTWjIUxJspJz7zn9FsRB0ABad8Zre2JZU0DpduG5poBF3P2x95qK8WsJlARAPrpvhC2CduRzfRMwyTRh0nBlhsJuPK7k+BajGZfjpg4wET6n/olKgf7IsgtOmBifpSpdn/NN5nxIyc6+wZg2D7HVDWLHYjYh+r1N3+S5If3lOe22On1drucq6pF5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fc0bLh+2YhfI1DOOmq7abOr9it+v9N04S3TScnKjyw=;
 b=cmZ+QDuBKLniDSVqvw56uRN1D3U6o949eSzGL1K0CawzW0c+eTDNojTuHvetGCzXhZSB1xGS8+TOOZCli1K4rLliAF5RjJhXD9ysj22JkgDruDPp+u3zRh75au/1/KXZyj0yxp+YZFkvldsh/hqeusabfl1XYIXBKg0xmoL24lo+umhqUkXG7BucEzbD8QF+g9WfLuHScb7xJ9Utqo0eiFg7aDikLK/2N9FFuZN7vYfr1zH1DgP5/HEVJNWQkyQEPzQ7SRCZMjoltZMSmzdpIZNJX+kNbTi7/Q6uCzEx/LLBMwWkZDl7KFfToH+1zcx3xjSFNl+usi+uw2CyN3/uZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fc0bLh+2YhfI1DOOmq7abOr9it+v9N04S3TScnKjyw=;
 b=eFD0KQW8NSSAF0aH/AqXMZ6QZDKH8yVpsoNKuwhZE4pNO+SD0irmqLBAzdA28e6MIKgqfQ77/bTQ2EbAaMCzrXTBZ6PQjsChp005saBVKzYiX7+ABx3yIDov9Iy26xUUvVWjm8QaRms7wW/pYoqXITKAxyPRJBt9e4pw15dyAHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 14:10:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:10:52 +0000
Message-ID: <e82ec662-22d9-b331-0880-886bd28624eb@amd.com>
Date:   Wed, 2 Aug 2023 09:10:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230711221427.GA250962@bhelgaas>
 <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
 <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
 <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com>
 <CAJZ5v0jvxrDMR6YHFpYZ4yYpp82-3TtrH==SMRFtUMJsv7=i=g@mail.gmail.com>
 <37b005d5-68fb-f8dd-67e2-c953d677fca2@amd.com>
 <8298c01c-abec-914b-0542-459f38c635fe@amd.com>
 <CAJZ5v0i3g0JujMwikB8niRZ93hXJZqWtjrCjbaDmkMLUbMmwMA@mail.gmail.com>
 <d1b2cf1b-de5f-6c2e-c8dc-fdf60cd0882d@amd.com>
 <20230802052601.GM14638@black.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230802052601.GM14638@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 805cbfef-2ca3-46ed-c52b-08db936247a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hnle5SFY5aAySVCFugScfiFguu+S8zb96sVaZ+m5NF6xGKbDvr+V7pV/A8HHArj655N5t8ebV5nR81kVGc5mt/B8cPXDP7BowcVfCqrpUt8ozkIWMvxuRpGb63sYaJr8mHW0BaGCJgMVDz7UCVOZkPhg1lI9ilxHIW3Rf6f34EdbjbxwqmOQBp/tr16hoX/SzLKUqkuCtFdekAyHhwvMPy+l2NmdCaMH2l3Q4sJPd3se1fy3Obx0SgOpGvNtHYmMkuZ0YG5LcP4+ztqEvHvR32jiNd6wy8/1YHw8WxVMWByhKy7Hi+PpcUqtQyo+9ajOWLl41NietBnItrrjhUwAn4l6QHFuxbnBCv40ww06pABFGkuCEpYKaYNw+oKwcTMtCo3WMtZCc2dYWgGUwvm9BswsfKtvS6DWL+NvQxn4l4eJIuhBnjryWACc7YVpS7GFkstBKTTAOvvZ0DBdToGV9wPAqZWAymoBEnuJ92b27TXJJXCyLsj+a49ZvKC/crXgoh8EYXPxgjvT6AQi6IWS0JdW3cmC5lGQEqi27qbfN5O13FwlsDpvHWSy9nfP2W+oVM7d91dSqKXuhnyxna0C4sfVCwhwYaZHlDykxAiRrobt4qGgXGak2nd5U2qYPkhbQcrnl7p8Q4VU0Q/js0d4Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(44832011)(66556008)(66476007)(6916009)(4326008)(66946007)(2906002)(38100700002)(2616005)(53546011)(186003)(6506007)(26005)(7416002)(83380400001)(54906003)(86362001)(31696002)(36756003)(478600001)(6512007)(966005)(6666004)(6486002)(41300700001)(8936002)(8676002)(5660300002)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzkzRG85ZFJVVGpxeDgvV2dJVnJUYlF4T0VmWURWbnFxZVhwR2QvZFpIclpn?=
 =?utf-8?B?TndkYmRnTFJTYXZCbTdaTUdaY2Rqa21TZlNKTVZ3SWlEb3hiRGd0UkNVWitO?=
 =?utf-8?B?Z3diNjJFem00SU9lait1SnNuZjFobWJGNXVGbDdjSXVLZE83Z200MHNBdlpl?=
 =?utf-8?B?TEJxQjkvK2lpN1lWRkw0L096M0dvNG1zcXVaNzRrU3RLakxsMm9TNWQ0Y0tl?=
 =?utf-8?B?VHVSc21meEc0N2MrbDZOeUhhZUhGNStiajhPZGhBYk40dnNkWmpMd20zcis1?=
 =?utf-8?B?Q1RzQUdPbGczeFpldHRnWUNiaTM5OFRTTUxUVUxjbndRaGhUcVNHVGlEZWhu?=
 =?utf-8?B?VTExZUN4dlFDSW1pTTAzL0phc1JTVG5pZmF1WUE4MGZkYk00M0VrMW45UGsw?=
 =?utf-8?B?K1d0Q055TG1pOFlnSW5HUy9PVmU5OUpGVHB2MjRZSjlRN0dxQk5KMEJtN2hE?=
 =?utf-8?B?eFllUmhHVEc3ZkhWMHN2aTVwRjB6eHo3Y2NKamJPUHNGcmVCa293YU50eDVa?=
 =?utf-8?B?WWVyT2YxYXhSYllSaE5ZdnJFUnlUQWNQR1JzZ0JJSjA3UWo2dW5QTDY3c1Fx?=
 =?utf-8?B?TW1WeTlCcWtma0FIMy9Sd2dsbTlTOC9tTjBWS1c2K0lIRms0eWdqeVdiSkVQ?=
 =?utf-8?B?emRVN0xqZTBOTGJWU0dGU3NGVjNoZHFONWMzaHpSMFJyVEV3ckliTlZONE80?=
 =?utf-8?B?TUV1MHR3bnZEUnlKZ05oUEJETEZRWkZPYTc2NVErR2tKKzVpbEVZNTNnNE9H?=
 =?utf-8?B?ckZtT3plTXg3akV3czFMZ1FZK1hXNHlFRVEvS1dJSUlFWU9vVUFEWmRpaEZT?=
 =?utf-8?B?cERGYjNXOGcxQXVUOUFVNHlYdFdEbzZiMHk3NzVCZlg5T3FUenNZdUVUUW0z?=
 =?utf-8?B?WHhuVlZOczJnWDdZdjhvQnI4dnVHSnZDdlhSVEJYUWJuNGlqdUhQaVB2eldZ?=
 =?utf-8?B?MnZwNmRIVStvSHpLRE96Q0xVTlUyT3krd0tvMFV3bitUTThRYVlXVTBlUGNE?=
 =?utf-8?B?WU9UUlVRcTd2Y25PSXROVnAwSTQ5Nm4xdDRzVlhoaVlOSnJUK2FqdzR1ZzRH?=
 =?utf-8?B?djFNMXBVSkVYMnZqZFRYdzhERVVrM3pEWXFwck85bE1zMURyVXpOclVuOXZr?=
 =?utf-8?B?SjJvNld2ZExUcUtSdjduNmtNd3dqeHhDeUFBUmdYckxlSkFlbHdWeS9WQUFE?=
 =?utf-8?B?SzB0QXk1YUttRUhaOCtrTnpHdUdmRS9iNElmblV3NmU2Z3NNYTBZcEswbDZr?=
 =?utf-8?B?K0dSREU3U2tXS0RUSFgwVEo0MzZ1M0FmcDVLN0d0YlM4Wks3L090YVJCaDZF?=
 =?utf-8?B?dngvaWdlTWJVZXVOSVI2WktMblV3QXlLaDNYUFlNR3JnMFdLcVp1NEJDcnd0?=
 =?utf-8?B?VE9DQTlyUU96cEJESWFncVVBZXVLektOclJDVGlOcE43ZGp5cG96SFV4b21M?=
 =?utf-8?B?M2w5Y3d3TTl3eWpvQzN2UEV0THJHalBidWRVcHVncEpLTjk0c0NKeXlxZEU3?=
 =?utf-8?B?R08zNlFpOEtveDA4QmxLR1BMODhCc3ZuQ043djlwQnZ5cndwcTZnMUV3MWRW?=
 =?utf-8?B?ZFhYYW9kK2RITDJRNnBuUFJnSXI2MzI1ay9KNWZDK0drVVZocmxISHFKSHp4?=
 =?utf-8?B?b1BWbHRWbU5HckJGMDNKWlFiaFBzRTVORjdVdjBsZytwQzZhS1U3YlZvV0Qw?=
 =?utf-8?B?OXh5OVB4WHYvUVRSaWZuTTVFd1hoZDgyWjVDVXp1b0xQMnFmd3l5VExpZXVC?=
 =?utf-8?B?bDBHaHFTc1RyLy9vdUp1Yzc1bE1NWDFoRGxvSW1TL3MxazBsdUtxVXlGUHBa?=
 =?utf-8?B?Myt2Qm14dVJjaWh1Q0laVEpscjVIckEwWU5NWTl4VlNnRGpmdDU0elhGeDRM?=
 =?utf-8?B?Q1l2VEZQYWJwNlFiUFovMmZoNlVwS0kvOWJRaTNld05Nck9FTmJ2V3pMci9j?=
 =?utf-8?B?V2Y0VUZ3RlFrcGZvQ21BQXYzRmpLU1FDRk4xVmh0Zyt3UmJUS0g5cDZnOENT?=
 =?utf-8?B?bTM0TnZpc1EwclNnL2lMeEt2VWpYaE84VWRlN0RrejNzamVQaUpPay83MnRn?=
 =?utf-8?B?SEkwRWdzVGtzUWkzOVVmS0Jka0JuaFlid0hyNHNIU0h3UWowMW5BVzV5MWxM?=
 =?utf-8?Q?OxfAYIaoUybWcc4ahMpxjp/p7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805cbfef-2ca3-46ed-c52b-08db936247a3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:10:52.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55bFdmv82W57Iad2w1Ma+RUm9UMe6lPe3KfC4N4nMwgdtd6eQrbRaNtooZBNh7k1u+dd2GYEiujNNOBZgHq63g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/2/23 00:26, Mika Westerberg wrote:
> Hi Mario,
> 
> On Tue, Aug 01, 2023 at 10:17:11PM -0500, Mario Limonciello wrote:
>>> Consequently, platform_pci_bridge_d3() will return false and the only
>>> thing that may allow the port to go into D0 is the dmi_get_bios_year()
>>> check at the end of pci_bridge_d3_possible().
>>>
>>> However, that was added, because there are Intel platforms on which
>>> Root Ports need to be programmed into D3hot on suspend (which allows
>>> the whole platform to reduce power significantly) and there are no
>>> ACPI device power management objects associated with them (Mika should
>>> know the gory details related to this).  It looks like under Windows
>>> the additional power reduction would not be possible on those systems,
>>> but that would be a problem, wouldn't it?
>>>
>>
>> I've been thinking on this today, and I at least have a hypothesis about
>> this behavior.  Perhaps Windows is actually utilizing enabled PEP
>> constraints to enforce what state device should be put into over Modern
>> Standby cycles in the absence of ACPI objects.
>>
>> In the case of one of my problematic system the PEP constraints for the root
>> port are:
>>
>> Package (0x04)
>> {
>> 	0x00,
>> 	"\\_SB.PCI0.GP17",
>> 	0x00,
>> 	0x00
>> },
>>
>> That first 0x00 means the constraint isn't actually enabled for the root
>> port.
>>
>> Mika,
>>
>> Could you get an acpidump from one of these problematic Intel systems so we
>> can check the PEP constraints to see if this theory works? Or maybe you have
>> some other ideas why this is different?
> 
> The patch adding this was merged in 2016 and unfortunately I don't have
> any of the ACPI dumps from them available anymore (and do not recall the
> details either). I think these were Apollo Lake-P based systems with the
> initial runtime D3cold and S0ix support at the time.


I scoured the web looking for acpidumps a bit an Apollo Lake system and 
came across this random bug report:

https://bugzilla.redhat.com/show_bug.cgi?id=1591307

"Intel(R) Celeron(R) CPU N3450 @ 1.10GHz (family: 0x6, model: 0x5c, 
stepping: 0x9)"

I looked at the acpidump, and I notice:

Low Power S0 Idle (V5) : 0

That means that Windows wouldn't actually be putting it into Modern 
Standby at suspend but would rather use S3.

Considering that result, could we perhaps adjust the check to:

if ((c->x86_vendor == X86_VENDOR_INTEL) && !(acpi_gbl_FADT.flags & 
ACPI_FADT_LOW_POWER_S0))

Or could we quirk the PCI root ports from Apollo Lake to opt into D3?
