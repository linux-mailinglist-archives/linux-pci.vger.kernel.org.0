Return-Path: <linux-pci+bounces-16887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560009CE23C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 15:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D252824F6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388561CF5C0;
	Fri, 15 Nov 2024 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YHi+gvWR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2014.outbound.protection.outlook.com [40.92.90.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601411BBBE4;
	Fri, 15 Nov 2024 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682213; cv=fail; b=FkNLOmWPYnXQcLGA+k5ehLsJFR3WWc2A7Zu+Vy9IaW6sVQk9bFYG4DqCL2RouLIWAN89VjxY2My2Ah8p8cOpMP53fdTaTj7B3XSDf1/Eqo7NodfzNgjbTBK5d30lTBzPzAjq0AudUUctF+c8Gck9X4SASlCL2/dxfCXTvcvrya8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682213; c=relaxed/simple;
	bh=b56aKiBSIlMazrAK24dwQ7edzVG54ADAqXK9/BErIAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i0ptWp/0X0Cz1ItowHC11ObkSRfyaJd7eBYOE3mDv064BknoDwOogY8s/Z3SOLPkCxib2tlpA4oCysp6VWvJkOcDS5cCf3JsqaKfFgzJrsU/2VvE9dSp3flg+LDEg46A0RHcSIhZoWer/vB/CJcX/lQuXIM63oCxTaZtJmzPWDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YHi+gvWR; arc=fail smtp.client-ip=40.92.90.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNtrWwmF8jB6ScX3NSJ2k9pLWnzP16AMIzTwpipeZzwfRujkt+lAf24HPIyjihZ9gjL7oUaNDle72febhTStf1a8hOHBVXjhiN+maiX9DmOZNONwSS1Z7Cw6KmO+NpeIPqvVvdoRqXAfI/uk5KuFxBQp10dLK3UaqOoXOIX90YtftGEXS3jVmuNfmGNnUx/hUFOAYbcEEcqUiVbdU/Y2vDnX32sb/agZDtHsjmTXrTgvoPcPzWfST4hQprchifU59cQKq7gZPtZzf5+0UDgxyFU64o861+cnB9s542TFvxeBacAi7+o9+yy8Ke3bpkWoWDiUgi2heKqte84b0vqKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJYJdWQQoISp42a3Q/a4PNkstwYsb1eKjDJHdXnl/CM=;
 b=zB9If+zEtwoRp7iNBP3msGN+kdRo+wrAo3IB/0CZwDAMCugKxNF8aBxny283575vYscTYKj3in006UeFE5zZWQsPs8lnPRAHdCKEbPIa11Hjo4HjAI3+Qnj4C33FK3MO9HobaxRMtIpVnDKH1GrYbzG7YaLXvPDxyqFDezta7qr2/oS5ZAd57sydFii4/+ws1FYkFeiO4RaX/N9gCaQQk230PcQWLOuXL9Dl0ELenACFl5snDTLB7Dzlnh82iPcAkCptbyN9aFHBagEwt1Yp4+lu7xgOalMLz8wjY47W59yw1lUm9HugYfXaYHk0GiTK81qgVjp5zz6bjSQVp1K/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJYJdWQQoISp42a3Q/a4PNkstwYsb1eKjDJHdXnl/CM=;
 b=YHi+gvWRiXj1gJyuwPrhx4mjYUnXJB4Z6D28wMAjPKOnYKsmcZfBajJpvsAVtW7RYQ5l/l79LkghI+Ud9WxgjNE6LPlVbdJnDsZf6y6JM3+xWT40gdE41ojh7hzXJtazFtcsfuSsPkhcvOQhrFAYpESBJx0goy6AgePITNi0Y1HFibfT73XcptPyz3pIH8OInOenCt5WogAeAoDfPAUhpVVRUAFA+z7fz78lTbJcOSKVXPCyprL1zXh5t82YWNMg0yRo2BxU0GFvCHX/zB1F55pVS/cFTU6qsZkkDLL+v+eI4K0H8CZxVK5yKFGGWidlnfpXCrm+Ac4BuKLPqjJQkQ==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by VI1PR10MB8064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:50:07 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 14:50:07 +0000
Message-ID:
 <VI1PR10MB201607EB59D6C0884A57995CCE242@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Date: Fri, 15 Nov 2024 22:49:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
To: "Bowman, Terry" <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-6-terry.bowman@amd.com> <ZzYo5hNkcIjKAZ4i@wunner.de>
 <7cfb4733-73a6-4a07-8afa-9c432f771bb0@amd.com>
From: Li Ming <ming4.li@outlook.com>
In-Reply-To: <7cfb4733-73a6-4a07-8afa-9c432f771bb0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID:
 <dba155bc-3c2d-4f7b-92ec-3a56eff32ded@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|VI1PR10MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6b1580-b820-433c-1bd2-08dd0584cbfa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|19110799003|15080799006|5072599009|36102599003|8060799006|3430499032|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDFrQkY1OXNtN2JWNzE2M3hkZzl2QTNuNjNZQ1lxRlU4dGpEUW91Qzd0YnpE?=
 =?utf-8?B?ZjhIVDFpM2VxNGhFN3A0dXcvV1ZleWUrWUZVWHIzTTFqMmlxY1QrV1QrcnlP?=
 =?utf-8?B?Q3JINkF3ODFvYVhCeFpadlNXcXdINnFHbjJxSUZ2cmlpMkdhaDB3R21QRjFa?=
 =?utf-8?B?dTFvaFVWMUhSVE00WVVlbnBxMUdwSlVrN0E0ZmZna2ZmcmU3eFNYUUJUNFpv?=
 =?utf-8?B?RkJpYzdyd3lER1hIL2pqdU9LbmdjY1BZVzJyQTBVazExWVBrWEg5RmhnSklY?=
 =?utf-8?B?a29kN295OHJKNDk3QzVvMlh4OVV6dDZEeXpNZUtkVWJoZk9tZWlDeWhUU21U?=
 =?utf-8?B?YzYwd3BoK0dQdThjTlc1RDFCUlhLUjEweFVyeXBvVWtvR3Noemx3ZEtxN0Rn?=
 =?utf-8?B?SWxqQ2ZkR2VRMTg4TllvRGo3NkRaMzRKdHlxMEZUVld1dWFORi8wckh5TzBl?=
 =?utf-8?B?ZEhZV0VaaFhEUFJZdGpVM09ScnIrRm51Smx6Mit1Sy9QQ1N0NmpVakpkeTFs?=
 =?utf-8?B?bTdxU2ZLRmFEckd3ZjdtSFRQdFl6eUhJZDd2NDk0YVk4ZDFYMlZSR1diZHRk?=
 =?utf-8?B?UUtkQmlhZ0VqTjc0aHpiSitsM0YyNEJqTFV6WVYrUUJUQUkrSFY3YVUzTkR0?=
 =?utf-8?B?Q0Nzc2hoKzlBZDl2ZldhTlZ4cGtFR3JFNWkxMTlQNmR2VUlBNmlxOURRNzVu?=
 =?utf-8?B?blVrclpNbTlxN0FxQ3I1dDNMZW0yUEp2ZUo4WC8yR25pVTYvdDBsZk5BMGoz?=
 =?utf-8?B?cERKbndpWGpXQS9UZmNnZG1xK1JIRkUzMEV6UlU3OG9EU0VSZGdwblVOeklB?=
 =?utf-8?B?d2Jvc2FTV2pyOFdBS2JhN09vVjdXOThEMnArcmJvSkxzT1d2bTlWY2JpM1ZH?=
 =?utf-8?B?ZlFMMjhQOEFnL3VIOWFpTEx1MHFqTklUdDBnRVQwMXJHSEw4YjJwaU9YbThH?=
 =?utf-8?B?TUxDa2NyMjY3VkNYeFREUklLcnlYenhzVVhZS21Wd0NpcmJGV3pEU2RISVpq?=
 =?utf-8?B?RWFsVlJnSkxwS1d1eFFvY3phcHIwRmdvM1g5VmlvMEEwZmtRTjFwenVEbXBq?=
 =?utf-8?B?cFFnL09HalBnNjRGejU1bXlHaWd6MnlnTmQxVEVyS2M1M09XLzFVWUJDM2VE?=
 =?utf-8?B?d3lwOEtCa1QxMVF6OWREaWx5SjJjQXJ4QTY2aUtMQ3pnemFQVmZCRjdqODN1?=
 =?utf-8?B?L1RydlFVaWUwZWwwMlZiWU13S0ZpYWFHK2VJR0Jya1lqazR5UlNDbUkwQVQx?=
 =?utf-8?B?VUJRa3R4SGtRTkVkVzJxejlDNVhKSG5Qek9oNjgzOUNUbVdYdklyNjR1aUY4?=
 =?utf-8?B?ZUVhQTRSc3VTQVJHN1FIUGJqcTlMTkYwZ1RFT1RKR3VRd3ZyL080U3VoZ3Fs?=
 =?utf-8?B?VnJzK1pva0Jab3NUa0FlZU5tUVM2Z1J0QUc0OUhYcFFZQ2RFSlZkcWhXVzFK?=
 =?utf-8?Q?c0UYUsxc?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXhPTmVEa2FURmxMSnBwdVFwcG1GL0ljaHBKSFJxcHliZmhxN05Dcjg5dW0x?=
 =?utf-8?B?L0R5ZzlFSmdxeTJMWjlmalBLQXRzVXV1bE1Kd3V0MnR6TmtNaktmSk9Dekxs?=
 =?utf-8?B?blJNVG1uNGkyME5qNWVFZlhBenRoWDNyNGc5SCttZk1GWmg0VlRVbktaeU42?=
 =?utf-8?B?TDNLU2J4ajNuanV0ajJMdVF4VVA4S3RFRWt0UFZtWjVnUEE4WFFuOGVkbXdF?=
 =?utf-8?B?WEpvc1U4di8vWmVDN1RFaEJWcjZpTkluMDFzaDIxcW83NXVqakE3cldkaVZ4?=
 =?utf-8?B?aTZ4bGR6R0ZBeVNDRmJaOXlVWXJHbmRTUmtMRXJ1NXBqK0w2RGdkRElmcWlH?=
 =?utf-8?B?VzlITm5uL0lrYjZwNE1tRHpPOXhqZGp2cVNOZ2JvRDdpM0tDRTBXM2I2bTVB?=
 =?utf-8?B?ejNpYXE3a0FTTkE1NUtxNy9rVW9uZ01iOUxUQW1sWmRqSTF5VVhyT3BrNWRl?=
 =?utf-8?B?Zi81ZUJXOFB4ZWRIdlkyeStGNExBT0RiZGhMY2ZSaFJjT1h2MjRoKzI4NW1X?=
 =?utf-8?B?TjQ1T2hzK1Z1MU9jWDdLUkhidVdlV1FLb0pIWVgrVmd6T1AwVTMrazd1NEFp?=
 =?utf-8?B?ODBSeFdEOVdEaHVablYrb2tTV0V3SW91MnF5U0p1U25oZm9OWHF0UWQvNmRy?=
 =?utf-8?B?bHhnZng3ZjhNZXlwSC9RRlFvbWV5VzN5bEEvSlpJSHR5Zlpyd2Nia1lCS2VQ?=
 =?utf-8?B?ODVnYlBHQWdRWUdndkw3WDdaNGEzL1p2K24wVTBDN05vSDIzcTBUdmtHdlg3?=
 =?utf-8?B?MWRDSEZtbTU0ZHhYOUNYZkpBai9hMDRQZEl2Y1dnSTVEWE80QWZKMk9taFRT?=
 =?utf-8?B?VlE1UXhucTFlUktrSlBXbER5Nm51VXU4Vm4vM0lBS004Q0FIRkJzZGlyay90?=
 =?utf-8?B?WUpOWTBiTDNWWDZaMDFiZkErOWRLOVloeUxTRFdibXZjUFlKZ3lmNjlTcHBQ?=
 =?utf-8?B?VGxoMVRXMUhJUXRZRzNiS0VvYXp1ZDJxYm13N28zNUIzYVZid0R4RXVhREsy?=
 =?utf-8?B?cXc4NnJLczBwZzA5VWtlaWVkQ3NRRVI0OGpGQURxdzVIbG9RSkltOTkwbEJF?=
 =?utf-8?B?VDdyY3IrMlpsTDgzRlhKU3Izc0JKSjNPTVdnNTZhNDhZZGVlRWtSbHBnczdV?=
 =?utf-8?B?eGxGemNYdkltTW51VUZNNUtsWUpya0tLcEZMQ3Y3dEVpSGY4dkljS0FhRWVv?=
 =?utf-8?B?SVNzRXpvRXpqdExXaTNzSkROZWF3TEdCQWE1TDhSNmgrNFRzM2ZFb0tTRys0?=
 =?utf-8?B?anBkYWdyekJHdkRSeUo0bXNQTXIySlpFTHZTSTBFbXRFQVJhbnlNNkNNYkd1?=
 =?utf-8?B?YTFaOGI1dCs1VnNTdTZrTC82WlJMNzJFQ0FXMDV5NDR3RmxxRVJURFJQUVF5?=
 =?utf-8?B?QyttOHFsYzhLRkEydTNmdzlzQWI2OXFsZHBNUEVRbDdZd3JMNmNsTjZtOXZs?=
 =?utf-8?B?dnVYVEo4ZmlubHdEMzZtSElCQ1ZkNVVYelNjWnd6cmEwZ2MweExpNUhWSGJP?=
 =?utf-8?B?czUzYmNBVVk2MGpqbjJpNTFZNTB2dTJ6SUpKUWpVT2QyNktrN0tBbGh3NnEx?=
 =?utf-8?B?djF0VGl3UEFEN2Y1WGtCMDdjNDZDbnJqcnRSVmhDMENuSnRuWEp3dnFaUG52?=
 =?utf-8?Q?m1zIxHQ6j0mw99P3LX7YVc0Q4iIdE6Sh5GGbFJXvOOuw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6b1580-b820-433c-1bd2-08dd0584cbfa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:50:07.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8064



On 2024/11/15 2:41, Bowman, Terry wrote:
> Hi Lukas,
> 
> I added comments below.
> 
> On 11/14/2024 10:44 AM, Lukas Wunner wrote:
>> On Wed, Nov 13, 2024 at 03:54:19PM -0600, Terry Bowman wrote:
>>> @@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>   
>>>   static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>   {
>>> -	cxl_handle_error(dev, info);
>>> -	pci_aer_handle_error(dev, info);
>>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>>> +		cxl_handle_error(dev, info);
>>> +	else
>>> +		pci_aer_handle_error(dev, info);
>>> +
>>>   	pci_dev_put(dev);
>>>   }
>> If you just do this at the top of cxl_handle_error()...
>>
>> 	if (!is_internal_error(info))
>> 		return;
>>
>> ...you avoid the need to move is_internal_error() around and the
>> patch becomes simpler and easier to review.
> 
> If is_internal_error()==0, then pci_aer_handle_error() should be called to process the PCIe error. Your suggestion would require returning a value from cxl_handle_error(). And then more "if" logic would be required for the cxl_handle_error() return value. Should both is_internal_error() and handles_cxl_errors()be moved into cxl_handle_error()? Would give this:
> 
>   static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>   {
> -	cxl_handle_error(dev, info);
> -	pci_aer_handle_error(dev, info);
> +	if (!cxl_handle_error(dev, info))
> +		pci_aer_handle_error(dev, info);
> +
>   	pci_dev_put(dev);
>   }
> 

I think is_internal_error() can be moved into handles_cxl_errors(). 
handles_cxl_errors() helps to check if the error is a CXL error, avoid 
this detail which CXL error is an internal error in 
handle_error_source(). Like this:

    static void handle_error_source(struct pci_dev *dev, struct 
aer_err_info *info)
    {
  -	cxl_handle_error(dev, info);
  -	pci_aer_handle_error(dev, info);
  +	if (handles_cxl_errors(dev, info))
  +		cxl_handle_error(dev, info);
  +	else
  +		pci_aer_handle_error(dev, info);
  +
    	pci_dev_put(dev);
    }


Ming

>>
>>> The AER service driver supports handling downstream port protocol errors in
>>> restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>>> functionality for CXL PCIe ports operating in virtual hierarchy (VH)
>>> mode.[1]
>> This is somewhat minor but by convention, patches in the PCI subsystem
>> adhere to spec language and capitalization, e.g. "Downstream Port"
>> instead of "downstream port".  Makes it easier to connect the commit
>> message or code comments to the spec.  So maybe you want to consider
>> that if/when respinning.
>>
>> Thanks,
>>
>> Lukas
> Thanks for pointing that out. I'll update as you suggest.
> 
> Regards,
> Terry
> 


