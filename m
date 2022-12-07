Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D788F6462E4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 21:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLGUzD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 15:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGUzB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 15:55:01 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36FE117D;
        Wed,  7 Dec 2022 12:54:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bL90Oj6ROGOSavIxjhDjhrdGusP3OHJA07DzkUQqFvurJqcp7//lF9lPt3pCpC+vwKHzNPPkCjegVA5ctbZWBhnlEgOYtmidZ0rZChayryde1Cq8z271kxPSA9hVQt54nPLCQ9EVvLcrffX8mfDuiotAyWLFVIXorqxC+lJqRWRnQBFUeg7q9uYa5LZ6bWYPWuS9Klt/P/mhUhST0Jf6sGS9TtMdMyc9Eu2kwzdfftteLxrppMUyhiH56QEBXKZxL49lqmcxUjagoqFoc+lIkUtoBQMYn1Wn13XK39od8GDpwwgAQumKGXsoDtTpS/GW7RmcTJIs5heWJPOUFNZpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGvCdL/oYUJcn+q10TnuYnZSRA35qUQ+9BEwYvc8btQ=;
 b=GgBkj/6NrPf9kQpLoARrKds58S9X04I8+6SA8ub3ivh7fEgejIg0Qu5shgjsyG4B6wF8fmiXMLqRQA8pSQJPGi9yt8lOEZ1jHP3j38U9CwWsWb1Kv91WGfNRmdgaa90wXUUXHIT7kesEQ4emsrg32tHIg38R6AnXU9hDAeR3fQKVOiqsjcnaXUt/UIQ71YKvEyROMt+vx8lk+5Hdr9Nne351cYUmFFccvlPdxfS8rcVC1JahANkIHv8Gb6hSkcch2hDg3kRjUmwFoQeiNYGvTvjN4MXe/UKLuXVdcMsdKvcwxrSdp7u18Skh/ijkTWpsOY5gGMtO4KjD6Oil6TXriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGvCdL/oYUJcn+q10TnuYnZSRA35qUQ+9BEwYvc8btQ=;
 b=SilRPi14S8ydsM1OlV+pJ4oYehYYxU/Je1Kt2VhoqnjKJrmIGNa1SiZrr1u47JZzERPeCTYJFPbSh0F78N+D3Oo7PB7VLD+qteM5SBIROgXjUd37SVWPSK3oPZVZRbkZJ5UZ5cjLlomZEFrotnPcjk+WlBzVBG0Puz7YwJwHSP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 20:54:58 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::6b84:1aa9:19fe:71a1]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::6b84:1aa9:19fe:71a1%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 20:54:57 +0000
Message-ID: <be9512e4-6d2e-3f52-a7d0-5804aa049e87@amd.com>
Date:   Wed, 7 Dec 2022 14:54:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [v6 11/11 PATCH] cxl/pci: Add callback to log AER correctable
 error
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com
References: <20221207202920.GA1468863@bhelgaas>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20221207202920.GA1468863@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:207:3d::15) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 0190ebc1-6749-4aa1-666f-08dad8954cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YJz8xIFZ4QEBL+Itmnq94m/hgNkoG0klwz8zKGCZcc7Nj+AUSiE9q2E//v0NTstCWY73b+YcmbS7mOUe6Fr5MLqdeE36jGnm/irGt7IgCbKGjk64RvTFDGnGn768pWG9hI2jnqwynr6gS/ezaczVq9F6Z81F/mYVntxI2ArzkTDBQTxrZ+B43Ghf9j4+fNggHp4e3xalCQpUQ34cSZ1OLnm+g5+L2JlTCCMKekqCgoPgXuOxjNxkKmdFVuBQVJ5st7RgwXr59p+8CbjnK2PDdrwf2cYLEr60SefYgIcCnhJTe6YxC5uKnqsvzYfdD2vd8Tk7+eq/GSVq0FDML9fyuVBXqkx/CvlB3f45+0KgbfGFMQwwilvyQVA5x2ORY8jBXG5dSY4NYxaONsiL/TaHtXEKHA7XsmTp97020jPgWS/JVz2W9Zn4ZVmDBgPDR7MsazeGhMF73gwtXEQuWP2fDuhMDUzgRCHtaJgFVak4BwbzvtZ9LAyVjMZkYOvSred5i+NDRcmbp97na/5te/oIzlCgJOcgraCBN1oL80A6w9Z/rFHOeKWqCWaVEZDLVVtz6PEn+8oDUEN9lrtC10XrDko9gDvvhn/p2XESGXgtQ1tVgPog3+wvv5LFlralv0Ed6rzoW6hgweoc2wbutTDketyWWo8v1Of3Cv/x4kwjWQSawCtpkqdxu07GSHtcJ57v2Hn3fGSRjVDAOb1TH+IetxwFJQ9cxJjPy17E+J3XQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(4326008)(316002)(6916009)(8676002)(66556008)(66946007)(66476007)(6512007)(478600001)(53546011)(38100700002)(36756003)(6486002)(6506007)(186003)(26005)(2616005)(41300700001)(86362001)(31686004)(31696002)(5660300002)(7416002)(8936002)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEg2RHhoRTdJM3VlcnRxck1kTUFrUk41cjlndW1CNG1JQVZPaW55K2JwRHVx?=
 =?utf-8?B?UzJPbmF3ZnQvTS9FOWtPbHVTQXp2NXhXMnhXeWVMaCtSYkFqTEQvNkgrZGxI?=
 =?utf-8?B?OE9WMDdTTkZHM1lzOWVRS0tROEFWaFk4Vi9vRGt3c0JseUJGUlJPOHNhenh2?=
 =?utf-8?B?Snl0ZUFWU0VsY2p1N29WT0djeVY2ekxkVjFxalVhNFE3cVZtZFhwL291ZWRZ?=
 =?utf-8?B?R3o4bEdORjdPcnA2UVNjSFhPejBYMHVWYm81NkR6MnRxV00xV2VRZElKWGha?=
 =?utf-8?B?ZEpBQTVaQzc1a2p2QnNOYUplU0F5UE9pOFV4WXp3dnI4OVhEemFsVW0vQ3A2?=
 =?utf-8?B?SzdQbllaczN0WUU4bk44NlFCeG5yckd2UThqVHUxQVBMQjc1YU56Z3czSFNK?=
 =?utf-8?B?ZjE5cnhSdlVKbWpCNExML0pUV0xQb3pldVovb1pxdUtJR2JsVHZhaW5XOWNV?=
 =?utf-8?B?QUo3b0NrNGpVU054d1Y5QjVSNW16QjkvTGNKSDh5S2F4cEhHaXozQVBCZGRT?=
 =?utf-8?B?cUNvZjRtVnB2WElHZnRITDJjbWtEWGkvUms5aEVaYWw0U0tyQjJoNVhsTkcv?=
 =?utf-8?B?YW1GbDJFOWdkNkRtVjUzWkJwYS92cDlLMWxZcWlCVitRWjhUYWxaa0pDamgv?=
 =?utf-8?B?aUxSUVJUTVBnd2RsMkIrVk1ONjh2YjJYcWVMelI4K0NTc2xKWDYra3BUS1gz?=
 =?utf-8?B?enlOT0NDUWI5bk9rbHZhUnRkTE1ZNnAvencwWUZWU0xCaVJUUVNXajdxNGpL?=
 =?utf-8?B?ZW9LMUtyZEZtdFEwQ2s4ckk1NE1pTnk0Vkk4RXhVTW1oRTIrSmxVSTV6YVBk?=
 =?utf-8?B?VjhzWjVCcm9peFVsbmRaU0s5MHQ4T1BnM1p6L1Z2eXl2WWlLeHdwOU1oSXpS?=
 =?utf-8?B?RWFqRTJjc2tEK24venpJRFRONjJld1VRaDk3N2tSQ2wwbVEwRDNaVXdqVnd6?=
 =?utf-8?B?VHZXT0FpSXVOZHdZTDl1K2d2dHo5QkJiR1pqbG9ncTdpYXZ1djU0U3g2QS9T?=
 =?utf-8?B?RFZuT0xxd2FQWGxZOWlhZ0dLSDJ1YVoxeXNKcEZEODhUMnlKb1lKdVloRDJn?=
 =?utf-8?B?ZHczVUc5RFRXaEJ5MDFuNm9LV1FoNHY0NzFXU0xFcEl6dlZMNmMyZERiaTY0?=
 =?utf-8?B?d3hVVUJFWk5vT2hzdGIyeG5LY3IxdmtxeTk2UkJNQ2doU0ZBcDl2U1hXWElk?=
 =?utf-8?B?emNqcWNIWGlVbDZGd0Njd2hLRittUkdxRWk2eENoUCtkM2J4UndFYzNobnRG?=
 =?utf-8?B?clN2T0hIWE0zVHR1SWFVa0xWQm1QeVAzMkllQlJvUnZLNWJWSFhBUmhMSUFY?=
 =?utf-8?B?Y21VNDh3ZEdkVmw4cENDaDJRNG51dzJKMThMRVVkUEtzQTBlRGVkR2NyL3FL?=
 =?utf-8?B?bUl3MVpScjd3bWZSRSs5ckNCbFBWYzI2blRaVGYvNjFtZjRIMmFYTDZ4MXE3?=
 =?utf-8?B?cnFmSmVERWw4WGh1WVI1OTV5YjNKdjd6d1pDdUpoNzEzUmo1TEpDUW4zRnI0?=
 =?utf-8?B?U2ZBeDNReW05a0VhZEtGN1dYRmFDZHAxR0pxUmVjZGYwMDRmbFBUREluRmlh?=
 =?utf-8?B?cFpmUmN5NzNjbFVraStoN012ZFl4bGYwN2hpT2FUREZmWDF6K010SE5lZDRk?=
 =?utf-8?B?Vzc2NlM4RjZEelV6Q085OFJTYjlrc3BPMTZBTFMvZ2J5Rld1SkdIcVkwaDcy?=
 =?utf-8?B?MWtKSkNUSDRoVkRWN0NIbGE3cTFCSWxRTmZKc3h6d0NFdDR6RjVmWUpXWkd2?=
 =?utf-8?B?bVdDS1UzWlpsLzExbmU3TjJzOWE4eVBQRUxhWmY3VjNwZE9DV01OUWNWM2JN?=
 =?utf-8?B?Wk5rTVBWeTg5Vy9tdWZkQWFpMzA2a0JjdVZUNVV0VWlvSHNyNXpBMjdNYmNT?=
 =?utf-8?B?SDFqS3pIby9Hdm5YZkVKc0hPL3d3MHhOVytKaWJDdGtkQllMSHRFY3JtdHpi?=
 =?utf-8?B?Ry9HaGdEOTNvcm85WlJkOVdsYytuWFRveDhPSUtzVlpDb0kwT091ZmVLM05N?=
 =?utf-8?B?R2ZWUlEwY2ZHMHBjaTk4cThaOUNJWXJxdnAzaGRyTnhMN1hhY25HcHpNamRk?=
 =?utf-8?B?WldlZVBCbTUwREFuTlVPeHk0djVYZVBYZjBzOGxUWU4yTHJ6YVRZdStpZVlN?=
 =?utf-8?Q?pcpP8cHWndT0SLvbmHPh9jjA+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0190ebc1-6749-4aa1-666f-08dad8954cd7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 20:54:57.8507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJRq0IuIUszrs5mQiKE19QHSl5ngQ8crU+GhNzTw0+dRIVZ05mOANapVfBl9iX/Y+7iCPsYtr4330w4doIUMXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 12/7/22 14:29, Bjorn Helgaas wrote:
> Hi Terry,
> 
> On Wed, Dec 07, 2022 at 02:04:17PM -0600, Terry Bowman wrote:
>> On 11/30/22 18:02, Dave Jiang wrote:
>>> Add AER error handler callback to read the RAS capability structure
>>> correctable error (CE) status register for the CXL device. Log the
>>> error as a trace event and clear the error. For CXL devices, the driver
>>> also needs to write back to the status register to clear the
>>> unmasked correctable errors.
>>>
>>> See CXL spec rev3.0 8.2.4.16 for RAS capability structure CE Status
>>> Register.
>>>
>>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>>
>>> v6:
>>> - Update commit log to point to RAS capability structure. (Bjorn)
>>> - Change cxl_correctable_error_logging() to cxl_cor_error_detected().
>>>   (Bjorn)
>>>
>>>  drivers/cxl/pci.c |   20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index 11f842df9807..02342830b612 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -622,10 +622,30 @@ static void cxl_error_resume(struct pci_dev *pdev)
>>>  		 dev->driver ? "successful" : "failed");
>>>  }
>>>  
>>> +static void cxl_cor_error_detected(struct pci_dev *pdev)
>>> +{
>>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>>> +	struct device *dev = &cxlmd->dev;
>>> +	void __iomem *addr;
>>> +	u32 status;
>>> +
>>> +	if (!cxlds->regs.ras)
>>> +		return;
>>> +
>>> +	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>> +	status = le32_to_cpu(readl(addr));
>>> +	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>>> +		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>>> +		trace_cxl_aer_correctable_error(dev_name(dev), status);
>>> +	}
>>> +}
>>> +
>>
>> This will log PCI AER CEs only if there is also a RAS CE. My
>> understanding (could be the problem) is AER CE's are normally
>> reported. Will this be inconsistent with other error AER CE
>> handling?
> 
> I can't quite parse this, so let me ramble and see if we accidentally
> converge on some understanding :)
> 
> cxl_cor_error_detected() is the .cor_error_detected handler, which is
> called by the AER code in the PCI core.  So IIUC, we'll only get here
> if that PCI core AER code is invoked via an AER interrupt, AER
> polling, or an event from the ACPI APEI framework.
> 
> So I would expect "this will only log CXL RAS CEs if there is a PCI
> AER CE", which is the opposite of what you said.  But I have no idea
> at all about how CXL RAS CEs work.
> 
> It looks like aer_enable_rootport() sets PCI_ERR_ROOT_CMD_COR_EN, so I
> would expect that AER CEs normally cause interrupts and would be
> discovered that way.
> 

Thanks for the details. I realized after I sent the email that 
cxl_aer_uncorrectable_error() and cxl_aer_correctable_error() trace commands 
are logging the RAS registers.

Regards,
Terry

>>>  static const struct pci_error_handlers cxl_error_handlers = {
>>>  	.error_detected	= cxl_error_detected,
>>>  	.slot_reset	= cxl_slot_reset,
>>>  	.resume		= cxl_error_resume,
>>> +	.cor_error_detected	= cxl_cor_error_detected,
>>>  };
>>>  
>>>  static struct pci_driver cxl_pci_driver = {
>>>
>>>
>>
