Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B609B7ED9AF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 03:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjKPCnO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 21:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjKPCnN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 21:43:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2200.outbound.protection.outlook.com [52.100.171.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15BB19E;
        Wed, 15 Nov 2023 18:43:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN86uuFt4Jq71VPI9cYr4o3J1YDx/OjXH5w+6RbtvIP3mzRNj0A0pLkERITVqhqiY/uTYP/Ov8u+xdxwbJAl4D6F8fVV6oQhct+VyJEi9DXbofb7sGvvRdsZmtrgJv/q28arWIMRQd7bgvfm5UMLZXkFc7sYOZY6FZ3MHblL3xOVpvvxs5zOpVh0dZvDfVCAS3SxDJBDrxg+lXGhYYk1BaxGfPx5bqtCk4cpsqXTMEnMjANEKhIxaoC3q4i9XW6QpqO47hL3mf9uOy81saCNelnQ/ZTmxz/eF0bxgT+iC2ht3wiQpknZQsaI5II9/LogeJ9OSnvmwXkH5bk9Vwuw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23ARIXE32yuMYBmXkADKfm0y6KIeHsGeuDmxgeWPIQM=;
 b=PPYYCge1R/clYbVNV5+4LhD2ym55W5f8jjy+IG/dlY1m2I/YBSiMU0IWUtgO3IyVdh/NhmWO4efafs9uoj2Dgmb0XTg9G0UXVliE52bxKWf87+YtXlwlgSdWiXNeRbbsFzgY5fv+xGVxjIUrglFwe/O7E9nhsjObK6C2shwxgi5A8IJoDn5et+vz32xQ+NzsDPVxlT6rHnV+PFFkUVRvUyxmHxTLtcEbTxpblJfqB371hE73z8cPUBD6V58zln19Ix/ErBQk8S5Ls+eb73aAiTdu5JKFpVqJw/mQfuDxX4eJfErog9XR9kkQEgeKL+h7jN0PNAKtLFBmeTIXH+uVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23ARIXE32yuMYBmXkADKfm0y6KIeHsGeuDmxgeWPIQM=;
 b=BAK1DunW/2AD2rY8Bim9BWnrV67J+UvlWII5jFjR/udNNuEDkURcGVNYoH1IZOOQHwVIYiMu9Wfz7yCupZ5qTtpWMwSnTZhfudl+V8GfdIX15Ij9KBt34Tf9hxI5a96PpZuBcj8nZsoIwhj1qGlI6pY0DJq+14F06ZwGLWHzB80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 LV8PR01MB8653.prod.exchangelabs.com (2603:10b6:408:1e7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Thu, 16 Nov 2023 02:43:07 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.6977.018; Thu, 16 Nov 2023
 02:43:07 +0000
Date:   Wed, 15 Nov 2023 18:42:57 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v10 0/5] drivers/perf: add Synopsys DesignWare PCIe PMU
 driver support
In-Reply-To: <2a4c5d33-a26a-40b6-bbf4-268393b6de74@linux.alibaba.com>
Message-ID: <ff6544d5-c6e1-39f6-1f3b-6622e2484af@os.amperecomputing.com>
References: <20231104133216.42056-1-xueshuai@linux.alibaba.com> <51c926a0-b4d7-aacf-12ce-30fad7c5cb@os.amperecomputing.com> <2a4c5d33-a26a-40b6-bbf4-268393b6de74@linux.alibaba.com>
Content-Type: multipart/mixed; boundary="1372433909-652173811-1700102586=:2110"
X-ClientProxiedBy: CY5PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:930:a::19) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|LV8PR01MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c7189e-ce0e-4979-1514-08dbe64dc379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXpPOWMrZmdiSi8zSVQvVURPZ3RrdEtHYllMa252YlYyME1KM2pJaTdzM2JT?=
 =?utf-8?B?OGJ6c0hOelpQOTlsdzYyWkwxWUNxaEU1NzZ5OEJDNUJZWVZlTzhaWWwxNTd1?=
 =?utf-8?B?a2NmN0JBMkZIT3lWdmo1cVliWVN5VXk2QnlsbU5POU1yRklyK2Y5ZzNsVmRi?=
 =?utf-8?B?aW91cDc4bE50bDRQZ3Z0TWtyZzBMSmV2M1V4Ump3V2NyK1NJdXNBbGJaWTdo?=
 =?utf-8?B?QUVSdUsrTllQSHJ1TmJLRk9mT1Jja0VEODBpblVNN3dCZTdqdTRsYVl2NG9I?=
 =?utf-8?B?OGxzejZyUUI5c1RoekYxZDM2NE9hM21RZ0MxMUdoU1RUSDBuVk5hWnMzMnM5?=
 =?utf-8?B?WjhSd0FUSmE5T2lTSjFGRjRSSDdBelh0d1R6RWxpdGtRK2JqN2lLcXh0dTky?=
 =?utf-8?B?RnlHUWZTdmdRZnNYU21mMjlWdDdwQmNuZlAxR2c5QTYxZ2lydVVReGNzNTJk?=
 =?utf-8?B?TldsTnIwdmtzOWV4djZVU0Q1UUJaTEpXNDNsckdxeUtsZEQ1cVFka3dybzli?=
 =?utf-8?B?RGE2SzljYmx3TWc4YStXQVp1MkhMMDFlM2trMythNUtIVWNiR2YramdIMjhW?=
 =?utf-8?B?YlFGMGRhTXR6QURpZjFmbUhia0d2Z0QzQlBSTzlTQWtKYXErK1JOeXJzb2Fj?=
 =?utf-8?B?UGpHQzVpMWE3N25NVm1vOUUyZUF5WnFhOThXaW5XN20wUkZaNmJYUXJNOGU2?=
 =?utf-8?B?U2lrdzR3NGF0L0Vnb0N6T0YvRXBpM0RHSHhnK1JLUWRGdnM4RWhVV2VXRERh?=
 =?utf-8?B?azlod09qVm40NWZ3R3pCdEFSNHNNWk9FY05WdEJBU3hkUWRJMHo5TmRYbWdH?=
 =?utf-8?B?SFh4L1VmcXVnaVYrb0VuNGMySGwvTjRUWTBJTEZESGg4engyMmxLWUZvSEht?=
 =?utf-8?B?Q3V4ckxZVzhadDdEVHJ5WXVvNHBwUlRLTEZyckNxV0dQc1lEM1ZpNTVzQnlP?=
 =?utf-8?B?cXFIYi9zVzNQZ3pEQ04yYzdlcjRjT0g4cXB2a0IxWWgweGE0N0hqWFZudFFu?=
 =?utf-8?B?TjB3R3ZrV1VXajJ6UTA2NHpxZHg2RTE4OU5rVmlsYXM2Qm1tTERhRGhDRm5C?=
 =?utf-8?B?a3c3Ym82STJZdWVJWi81YjlzSklCeGxid3BSOUR5WVNua3QwWHd0M21jZDYz?=
 =?utf-8?B?T2o2RDkzVFFiK2RsVEdHSmdxKzhsc1RWU0V5VTN2NmsxbHNFOHJGczNZeWs1?=
 =?utf-8?B?S1c3ZUY0aWYwNHZBWEZ1WkJFWmdwUEZKVTkzK3F3aXoya0hTenFEdytRZ2tR?=
 =?utf-8?B?eUZrMGRuTjg4VWNLUEM1WllvWHVxRStOOUIwbjliM2V0VGtzVkFPVW55UFB1?=
 =?utf-8?B?K2FaOUdYSFRnV2FlZ2NTd1h1Y2g5QWk3Qkc0ZmdLWjRDYVJENU1RVmN2elZS?=
 =?utf-8?Q?tppt6mxFzLSCEgF0A0BwNQrZGRhbKyxM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(13230031)(346002)(39850400004)(366004)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38350700005)(8676002)(8936002)(7416002)(52116002)(33964004)(6506007)(53546011)(4326008)(26005)(86362001)(2616005)(6666004)(316002)(5660300002)(54906003)(66476007)(6916009)(66946007)(66556008)(6512007)(41300700001)(6486002)(2906002)(83380400001)(478600001)(38100700002)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXJobGlsS0xySkUxR2tTSStRSXdzbDg0TzZ3TVV0YnVleXo2Z0lRUEFlOHJ0?=
 =?utf-8?B?N3JrRHB0QUpwR2tFdUtRUzQzd3FBWHA2U1R4RnprdURISHltOGV3elJtczJv?=
 =?utf-8?B?ZElRMWtOeit3bk1CWXJRcGU2eTZ5R1Y3SXJsWmJXckJjY2ZZaUc2OU9PSzFB?=
 =?utf-8?B?eFhkbXgzRHRBN2hwbmpkQXFnNS9zaHNRM0IxdWNpc3ovWE9aN0lFMnB6SEg1?=
 =?utf-8?B?S0xlZkVsVXhVNUsvcE1SVnlqMXhKL0JjYzhodkpkVjQ2dDhyUCtUVUVJNXpw?=
 =?utf-8?B?cEZqZHhGbXFnMkc2cFRtSGVRRGYrN3ZNQUwxV2llRlFhejJFMDNXTTBqUjhi?=
 =?utf-8?B?NnpIM0sxWHRwdHp5NzlSU2ZKaURsWW5GRkpqSEZ5ZHhucmdVN2FYSHJ2WWZF?=
 =?utf-8?B?d1ZyRjJrcXdCei92Z2lpVXlGRXZqT3UvZzBDdXBleW5KMDdGVjRTVTI3Mjcx?=
 =?utf-8?B?MW8zZzVVbTZ2YjVKVENSY2tVdVVHS3pUK05wcjR0TWNaWmUyQm9OY2VMNWR2?=
 =?utf-8?B?Skp6M0tXOGE2d29hT3AwRzVBeG9QVHVvV0JsQUI1WElzTGVKcWZoRlhrTUUy?=
 =?utf-8?B?dUptVUY0SkpqRlRlQWVSdVBJZVpvZW0yakFBY01sMjFqRU00OTF2NjBsZHpm?=
 =?utf-8?B?SklzM0syWFhyanVCdjlFVy9kRy9DUVJtLzVtVGxEOHFDaHVsWVd4eTdhTVpF?=
 =?utf-8?B?enZ0Y0gxTzNTa3ZwNWVoaytYMzFSUFZVKzJpbS9vQnNodnJ3ZUlXM0VRS1dG?=
 =?utf-8?B?TTdFNkpURkpYSlZ2eCtQMkhXdENUMDZCYjMvbURmY0ZrbzNPUnRxQWFUcjhL?=
 =?utf-8?B?dVkxdVF3cXNOMzZkeVUxZnM2NUt5MkFpSGh2NHg4bTk5NURXU1NuSG5MR1li?=
 =?utf-8?B?K1lGVFFCLy9ISnlwQVY0SmsvakFyaWhqN01NdnVSamtzaHlWT20rd1hCSTQz?=
 =?utf-8?B?TUhmK1J0cGVRd1JXTkkwWDllQVc1RWRNNGdjR3E3Kys3UC8wcndEYTlRS05N?=
 =?utf-8?B?VGppWldpcjVaRG9MVml2MG1qTXpOdEpSL1Z3TDBGblBVVkppR0FBMkRqT1VU?=
 =?utf-8?B?ZEFUMUFUeGxPQ3FZR2V6aDZlZTRsRTBZS1Fpb0lvZTM4cjZteUtodVpHZGdP?=
 =?utf-8?B?c0swQ1IyampIVDFiWGcyNWFTOUFOV0tvMEEwaWlsY0d6OG9XYkxzQlNEelFv?=
 =?utf-8?B?dy83anlNMWVwK3FwVnYrZTVXQ1IzeFpWMGZkUzBVcHdNZUxKK1RFRWI4ZXBP?=
 =?utf-8?B?ZnYzK3BZNWFqQ29qcGk3NWdUWjhlWU9wUDBXTDloZ0tsdXFoT1lHYk9DNlRX?=
 =?utf-8?B?amt4NS96Q2UwWFgwb0tmamtxL0RQQjkxWFdtdmlNekRBWGxWZ0o0T05sT2Zx?=
 =?utf-8?B?Vnc4M0ZyZlprQS92NHBNYzN3bzdQUUEyM3N4dlMrYnI1RWJTanZZY3J0aXdo?=
 =?utf-8?B?RWpWUDBPbjZFb2FJbnFTMTkyTkVSbmxsWEF2aE4rODIrc3FoN1c3MGtINnN5?=
 =?utf-8?B?eG5LZGpvWGlWbS9IdEY5YWVERFBWTE9XZHVTUEFlcnNyeU9vb2NJZGZWQ2lW?=
 =?utf-8?B?aGNCa2hJaU02M0pybHd2NU0yWS9XZllKUGcraXlQdElBeGl4ZHVHQ0I4Y3F2?=
 =?utf-8?B?MlVRcVloUDBtMjdJV2E0alJFYVg4Q1Jlbk5INjRtcUtKcm5WQ25BNWlvUTdX?=
 =?utf-8?B?WEVMcStzZTlRWFBXRUhrbVVCZmN5MGpmZlUzYnp6c3JmSUh0OU5UNTRMMDhZ?=
 =?utf-8?B?dzBIZUdBUW5wTU1Ba09PTHZHQUZSUE92dlNOYS9tRDFwWEthbzltWVZERTJD?=
 =?utf-8?B?NUpCbHNPUTJkZWdGN2ZTNHp5c3piUGxUOFZ4Tkg2NEZJOXFEV1FXSXNGZ1Rp?=
 =?utf-8?B?Ymx5ZEJyR250UmtTanVWREFRMWs3a0NHM2hPSGlkT2UvQ3BDUzNzWGRqWDRQ?=
 =?utf-8?B?RTJXWG50UjVUNHRUd1ZIVFRUUGh6YmxhSWUzTkVUVnBXVlBUaTRIMFhleDRo?=
 =?utf-8?B?ZzJmK1lUL3pNU2p1TVc5QnhBSVZad1l1NllSY0ZxcmNQaFZMZDYxWldvTUhW?=
 =?utf-8?B?OHZpQS9ZUnNMUUJrdk5SaHQ3VFB4Nm9IbHFDN3FGc2FjN0diZGtpOC8vQ3Ny?=
 =?utf-8?B?dHV2MmdIQTB0Z2dMKzlQTytMSzVRQjVKSmdRTmI0QVQrZkUrYkVmdUlCRUZx?=
 =?utf-8?Q?oM09l9gFxKuOhULM6apbOeU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c7189e-ce0e-4979-1514-08dbe64dc379
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 02:43:07.1528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gl7sZIy1fQqc1sEu9ONh8UTtFDwynoWT6mtTC+TMbsUOLP28qq405ft4ZjhZS8tLTfbsGN7zCDgHb5BVwuoqNUxF/tzcDCKezW9ZH04tPrwf3BlHPNVNPIQ6mJotepEW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8653
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--1372433909-652173811-1700102586=:2110
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


On Thu, 16 Nov 2023, Shuai Xue wrote:
> On 2023/11/16 08:57, Ilkka Koskinen wrote:
>>
>> Hi Shuai,
>>
>> On Sat, 4 Nov 2023, Shuai Xue wrote:
>>> Change Log
>>> ==========
>>>
>>> - move the &plat_dev->dev to previous line to warp more beautiful (Per Jonathan)
>>> - rename error label with the same suffix 'err'  (Per Jonathan)
>>> - drop unnecessary else branch and return directly (Per Baolin)
>>> - warp out set prev_count from dwc_pcie_pmu_set_period (Per Baolin)
>>> - use PMU_FORMAT_ATTR to simplify format sysfs stuff (Per Will)
>>> - export pci_clear_and_set_dword() to simplify _enable() functions  (Per Will)
>>> - simplify _read() function by unconditionally calculate with unit in bytes plused if branch for group#1 event (Per Will and Robin)
>>> - simplify _update() function by unconditionally mask with 64-bit width plused if branch for lane event (Per Will)
>>> - add type sanity check in _init() (Per Will)
>>> - test with fuzzing tool before this new version (Per Will)
>>> - register a platform device for each PCI device to probe RAS_DES PMU cap (Per Robin)
>>> - add dwc_pcie_vendor_ids to extend vendor id for future added device (Per Krishna)
>>> - pickup review-by tag from Baolin, Yicong and Jonathan
>>
>> ...
>>
>>> Shuai Xue (5):
>>>  docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
>>>  PCI: Add Alibaba Vendor ID to linux/pci_ids.h
>>>  PCI: move pci_clear_and_set_dword helper to pci header
>>>  drivers/perf: add DesignWare PCIe PMU driver
>>>  MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
>>
>> As I mentioned earlier, I successfully tested your patchset with a few patches on top of it to enable DWC PCIe PMU on AmpereOne. Thus, feel free to add this tag to all the patches above:
>>
>>     Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>>
>> Br, Ilkka
>
> Hi, Ilkka,
>
> Thank you.
>
> I will add your tested-by tag in the upcoming version v11. However, I
> kindly request some time to wait for feedback from esteemed maintainers such
> as Will, and Robin.

Sounds good. Actually, I can give you a little feedback on the driver 
patch meanwhile.

--Ilkka

>
> Cheers,
> Shuai
>
--1372433909-652173811-1700102586=:2110--
