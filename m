Return-Path: <linux-pci+bounces-14222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4299991DE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C49F1C254AB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51D61E0B6C;
	Thu, 10 Oct 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="ia95oCBF";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="QontOYKb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0e-00379502.gpphosted.com (mx0e-00379502.gpphosted.com [67.231.147.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72351E1A23;
	Thu, 10 Oct 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.147.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587033; cv=fail; b=Du44fxQ5l2tUaNTfrVrOq8ChRcKaVPCXmHtrokfoRcK48dMUcoa+BnpHmpKO28MJO0/EswJKzaFwCh3CKLuZYKNuzVGTX1ZM/3wQ4l9gX4BHAwVtxeZo8pb9KAJ0RYycY7TCKVmcSBGSN6rock0ncLzJc4KMQxoqH2S1wVuVj2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587033; c=relaxed/simple;
	bh=RgRFIMh+6KtU42mKVE1snPhuDiyUQj1FGOzWhsYfZBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A5uM3NP7114D/3R9jpJ6pBDO/euPMhRiZduvlOrD9A+9ApCPBpQ7PW8Tozvt+XUlWoXA3MOifd5BbnMA5bfTm2CC4Cx+2EGVj4OFXuKo+Z86KrBJbG8Mwtyl3MCJ4rRJpnvlLLbPhMIA5Adm3ETkh1a5JqWMqgcadTqDYAUpI3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=ia95oCBF; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=QontOYKb; arc=fail smtp.client-ip=67.231.147.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Received: from pps.filterd (m0218361.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AAW0XM004659;
	Thu, 10 Oct 2024 11:54:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=YfeblbgXdU/o9hblby18upiJQu9rwJZMajDVHjv22Pw=;
 b=ia95oCBF0eW1VQPpiVBx9bMQqyxC6scrT9pgiJdO0fsZn82diwxvK6EwY2yvjkXp9BAK
 netMdw0HuugE5tr6V5VYXrhSibZazo+gCazailXbF3sxfBB2bt+RIhCiL3M5vplOxsmQ
 xZGQB9hodi2PSeiJSR2KcofFO+DT9fnhtbW5lUd+qMVUX6SD6bZJebo81uXur6mHvV8I
 TkEpt9FNkFCMmLjtdfocc3HyuMzjMy0/5VHYxRbJndBmMS32a5MhSWNP8/FCIDWZWsie
 ygk+BbaejhsGjwWvGGjVpypRD+dDP5GrknlfISZgtEhe8+A02jZ/flqVdNuoZrNqJ/PN Xg== 
Received: from bn8pr09cu001.outbound.protection.outlook.com (mail-eastus2azlp17012054.outbound.protection.outlook.com [40.93.12.54])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 4263fr9n56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 11:53:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2BCsAl7w6VgNNjDgvT79iDsV9Gnr4Ztp07t4g02GSDZwJZFYdmwIL0ZuUH9fnwbO15MXO2HLzfyjiaKIKbQ4//IqZ0SwL5d01S8AZLxvKU3ybb0HbvqSlflnkQ98QR40pgqLRt4S6S+CWPsqZ24beDstw7hn69jh+3nAhamVa6VpaZ77ZG61+gRrVmJhSm5lmgGOvj0Bcv1iwXe4HFsln+ciPA+hh+2tsQs5rL9JhGqiNRZw8WtkoykYP9jwOggIu3PNzN8G1cmMSaqw0iOixN9bJVctNeho/zvPsbv3k6sKHxjcpfQk62JGme3dvqwB6ABt4uhjcJtatHHjDBgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfeblbgXdU/o9hblby18upiJQu9rwJZMajDVHjv22Pw=;
 b=zQzMwPQ/QvqpzV6XJMRHQ6lPSLfOeB1AOVYR0Aoyr0gcKqNGykobOsm7LNc+WoEzl1FV0DBxWpai/0NoOZanjzT9CU/gDctsLttedSWmmLRALZKofaziU6ZflNoM7Xro4y/Aq2P5atNEVpEmVGo4iHQE/aXBwLkvQR0p6UYfvBv6xGqDgybySpWVyFOf1X5Nkdjm4Jwc89AGhVXMNCAOXuIKiOCngHM4L/dio4p4zg1m1XfdBuLZY7O38bE5Hupw4oSdkAOxFiA8GZTSuQfJT2I5JinrIn0qcbkTOB1dJ31WwVS3XCpZEQ3+4SaqdDPnIxc07g/7KtNMo0Tzv1l0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfeblbgXdU/o9hblby18upiJQu9rwJZMajDVHjv22Pw=;
 b=QontOYKbUYls5o3mlOZiUcYPv9O9pVXAKVsHYIu7jNtGoXGLk1sHRhUV9mpagNpc27yyJaOaMx346vK3UOhLad9HcMmsF5rZI6Pc91q1Cc6tMmBfbDsiwglc/f/GOWKvTjiwhCo+IoNMZBXly1uazpCcB4d4MxJoO8katF/llSE=
Received: from BY3PR09MB8834.namprd09.prod.outlook.com (2603:10b6:a03:346::22)
 by DM6PR09MB5351.namprd09.prod.outlook.com (2603:10b6:5:272::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:53:45 +0000
Received: from BY3PR09MB8834.namprd09.prod.outlook.com
 ([fe80::9fcf:fc76:1d:f39]) by BY3PR09MB8834.namprd09.prod.outlook.com
 ([fe80::9fcf:fc76:1d:f39%3]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 18:53:45 +0000
Message-ID: <5beda7c3-e5fa-4105-aefd-9d91fad6d967@llnl.gov>
Date: Thu, 10 Oct 2024 11:53:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED
 driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, mariusz.tkaczyk@linux.intel.com,
        minyard@acm.org, linux-pci@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20240926210259.GA13456@bhelgaas>
Content-Language: en-US
From: Tony Hutter <hutter2@llnl.gov>
In-Reply-To: <20240926210259.GA13456@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5P221CA0152.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:6a::16) To BY3PR09MB8834.namprd09.prod.outlook.com
 (2603:10b6:a03:346::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR09MB8834:EE_|DM6PR09MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8dd797-0538-4c0e-a150-08dce95cde22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUtaMi9sNXo0VTZ6R29pZzQ1d0hlbE0zZTF3cDJsUndZQVFVcHkvaWVscWM2?=
 =?utf-8?B?ZlVLbk1NL3A2dGh3RDFUUGNUT28ybTI1OVRSZWpnem44clpyR0hjdWhjU3dw?=
 =?utf-8?B?aE9lK05hNm85alAzTFE2ajBFN0kxZVd2eDE4YnY3TkppRmFZOGl6Y0tGNHYz?=
 =?utf-8?B?SDUwOG5sL0VwNWVvbmdtZ1BwUDhRTFNsd3ZaUEI1a3pjY3hrandvakQrVkl6?=
 =?utf-8?B?aGpxUnhPbHNFKzUxaHQrVjlJeHJiRy9NTTBNUVJzOUtyOVdLejZhMnNLYmlM?=
 =?utf-8?B?VUFlQ2d6UWJKdUh2cS9GVXI5OEd2bDZINHFCRGVVbjRyT1RVOVdEVGJVandt?=
 =?utf-8?B?WFJsaWhCT3JLVFR4M1pRWG00YjNjcDdrdjBkbDREeXgxd3JuNFZZelltd00x?=
 =?utf-8?B?N2o2TnBaN3lrbGcram5vQ0J5WHdXVnh2a1J2M2lTMktWSDY4blVNL0E5YTBE?=
 =?utf-8?B?TkhxR3EwdS80aExlOWdVU2xWZ2h3ZG80Zyt5WkVXTDhKWk5hTTFhT0xORlFD?=
 =?utf-8?B?WFdqQzBUNnkwRGdWYllxRlR1WGxPNk55RkswZ1pwaXBjUjlBcU45ZERCOVAv?=
 =?utf-8?B?bDYwTTRTWUJjRlNsTm1LTW13SUdpY284NHNVeVRwcE9KWGthMVBzNkl4cXZz?=
 =?utf-8?B?V0J0YVg5akpqZER2ZS8rYkYzeWFHQVdEd2JmeEwzNTlDK1pUeThqVUo4TUp4?=
 =?utf-8?B?Qk4zVklGdENucHhtOEVZRDNGaWJ4VjJVRXNwV3k4b3FELzdvcVBxeVhXd0Nn?=
 =?utf-8?B?c0pBb1kxQkVSWjJPb0Eycm9BZFFhc0Y0bm1uTEZldmFiWGI3U25OTUUyU0xV?=
 =?utf-8?B?MlhuVnNPWGRjRG1VeTRuQWE0K2txbHVoTmVaYUpNM3JnUzB0RTljWjYrV3Jj?=
 =?utf-8?B?YksvNURsQ1VLQlVaRE1KUS9haGVrK0M5RWRzSFloMHpEcWI5S1I5ZmUreDBs?=
 =?utf-8?B?QWFIQWwrL2JHdGZ6Z2JkT2U1VWppVU9Xckd2QW1ySEtwcjdYVG1WWkJsbVRC?=
 =?utf-8?B?Rlp2UENMUkFiZXNQL040eUZ2T0tOVW44OGpEQVROUXNqTGY0L090VjkzdTJP?=
 =?utf-8?B?dGExVG5KS2xxazJ2T3RMWjg4ZDZoK2VQNlFsamJ5d0E2MFZtTVppdEQ2Skw3?=
 =?utf-8?B?MHpnR1NFaEw0Zk80eGhlK0o2cGF3VmFLSDZnUEoySHNqSktad2NSUUUxUVBi?=
 =?utf-8?B?RmpKSDdCMlkzRDhRbHM2RUczRmlZUExvRXcwTzhERk5Za2tpNW1lTHlZdVJV?=
 =?utf-8?B?QmN5WThMR012a3l5NUQvc0Q5T1MwSHdvM0s5aHVFUjU3ajNoU2JpbEtqOUxn?=
 =?utf-8?B?ZHRmaEJqM2h1NWFVa05xVldEcnBsVTNUSnFEeUNUOWNqZFZwMitScmlwMjBm?=
 =?utf-8?B?dW9mUTE5YXNZUTl5WFdXNmtlT2xJT1VoYzlkTERya0lSNUlzQnV3TDZVUnhh?=
 =?utf-8?B?emlVbWZRVk9DblF0ZElhM1Nza29nTkRNcG42LzRTQ0d1S3lWN29GZG1HKzk4?=
 =?utf-8?B?N0FMdjk5NHhEajg0N3owZnpzOEI2WDQvMTBKOWF5emZod0plWUJ0UTE0Q0NP?=
 =?utf-8?B?Ni8zRUpjeHVlak5iQjNvNVVTVmFhNGVmMkw3SExadE9zQ3h5OTFGc3FXakVE?=
 =?utf-8?B?alh3NlZQbDZpNjVwVkxMS1owbXJ5d21lTTc3NEF4LzdscWM5TC9UcDk1RVl0?=
 =?utf-8?B?SjlvbnQ0L05tUThpYnk4Y1NBL3VBVzRxaUM3dngrSXQ2TWl0Qmp2QjNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR09MB8834.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFdMMjBoRzBRd29GYnlMdFJlRU10NEZJcEIwQlcxR244SFk2djE0dDI5OWdX?=
 =?utf-8?B?c2h6Sm9JNmlFaTR2d3hGdzJTRWlnV01QVDd5MklVYlpNZE0vNmptdy9RZ0N1?=
 =?utf-8?B?QWZLRkVvMWZyMXYzdE1zOTVrNjU4NnZ3QVZqZmFXazljVnloLzZ4L3FnMllj?=
 =?utf-8?B?NklHVjdJTWp5eGRFM0pvM0hLTVFHd2d0ZFlqR2tOcFZVT1QwNndXYk84N0E0?=
 =?utf-8?B?M3V6cjdHbXNtVDV5QUtNUEpzOVhQcVJDK1kwM2JocmZaa1M5VUQzbFVuZExv?=
 =?utf-8?B?SmEvUjdNQ3ZSSTNMOEJiYThDZ0hyMjVVTWoyd28zSGQ2M2gyR29XRzhRYkhB?=
 =?utf-8?B?UjdKU1RxSzNKY3FaQVFGZGtINm9zWWNGQVlmT3NCN2NOZUQrK1haYm9HaWcy?=
 =?utf-8?B?OGc3OFdIN1hpbmF4M2lKYSt2Y21Rbnc1L1YzK3hVdDk3T1gvaEUwUlNXNzVh?=
 =?utf-8?B?VWdKeDRGRlN2dXdNckZ0Um5lVzBwK24xTmZwR1B4TTh0VXNsY3dyeWgzemtT?=
 =?utf-8?B?ay83ZjA1bnY5VXpMcksvNE9yQk54aGJPcnpJRWM1am5uZjNTeWpodFlTejlN?=
 =?utf-8?B?cFpWL2ZxWjYzQi91TzRkY1RzWmJidUdjdmlzR3QrRStmdXIwRU1Tbmw2Vjls?=
 =?utf-8?B?U0dzZEF1NUg0TDJlZjA4RHZyVEN5Z2YxUGxsZ0RnYzZsQjMvQk5TUk55NVhZ?=
 =?utf-8?B?SmgrNGw4Z3FlNnJZVm4zSG1sOURKenJ2K2RCdTAwVDA1WTBQNCtLUW13Zm9Z?=
 =?utf-8?B?ZzNGcFBkRlVOei93QVJ0a1hzdkZpbjMycjlTM2lJTEFjbzM5MnFpNFZUZ2NN?=
 =?utf-8?B?eHRMUzNMZENxbVVwUEJjQ0QreGhLd2NXa0ZNQ3NBYm5JRVNMaUJncHRGZ09T?=
 =?utf-8?B?aFVXNWhjZ1FuSWl0d3poeFdjMG5EbEpQR2laMlZnTjVGVGVQQTNPRFNjay9W?=
 =?utf-8?B?ZHJZZEQ4cjkxMUNJT1V0WFhuSUJYQUozV3Bod0FBdkhhT21lWlRRK0w5K1RU?=
 =?utf-8?B?blM0MnZBbk1NQ0phZGZKSmxtU014Sm1rRHRlUFpjT1RnWmdLbVM4QzFPQVVu?=
 =?utf-8?B?SlptWnA3UXpmai9TdkIzS2J4WENuSG1UWGJBQlZneHl3ZGl5M25pb3ZBSzli?=
 =?utf-8?B?eDhzN0Zja1BNbXRzRmpRcUV5U2FmejhVUnI2R1pCem43cXpZbTJqalZCcWlE?=
 =?utf-8?B?bXNSYldqdTFSRTNoUkJuNkNSRm9RNFR2RnlHKzEzSkxBOUIrVFdkcTFMbGNh?=
 =?utf-8?B?NURvOEZ2b3hSb1lnV0ZTcm9iSGF4Z0lCbE92a1l5R0k3WmRaakVQMzlaZkJO?=
 =?utf-8?B?cEh4ZFdQVm5JNlJUMytLRllGaittRzRiek9vcE1IMzN1UW51NW5Ddy9UekZv?=
 =?utf-8?B?TDJvQ08rVkxudGJPVjFPRXE1QjM2K2dZK3JvVDdiUm80dU9Oc2t0NFIzMCtP?=
 =?utf-8?B?UnVNNS9RSHFmNG9obG1xMy9kYzhlZ012VnY4OW54eXIxS3NxWnAvaUZHTklO?=
 =?utf-8?B?eDZlVmZRQ1FNTEdFcGVCb2RYMkJ3cnVJKzZQd2R1R3g4UkhuWjJVOE93cDFV?=
 =?utf-8?B?RE1TbG11aFF5amdnTmsrYWozVXdoV09NOXR0RWprN2FuTVY4USt2OUVtaWdE?=
 =?utf-8?B?Z2d1YUU4WVpVaWpZVGxNcXZYQXh2a01PZ1lDQkJ2WnphSVJpaWxyQzF0Vmpo?=
 =?utf-8?B?ZWtFd3FGdFczeVphakZWUURNdWNZelFFZENEWlF0N212SHozb2oyYlBsVG5n?=
 =?utf-8?B?Tmw1KzhkOXhIeEdIRE5PNGNzbjU2TkdvRDhiMUhOZi83bWt6dHlZUDRUQW5h?=
 =?utf-8?B?QVF4SW1ZTXBHWG02T1VHa3ZpWGlaVDEzdmd1MFYzZFdoL0d1Tkt0ZXk4WnpL?=
 =?utf-8?B?Z3dSSDlkNjlRRjhxTm5XSWRFYWFzTnU2U3NHam1XMVFkZ0h3MVp6OGNJby8r?=
 =?utf-8?B?VXlHUUZMVnZoNmcvOFlpc3o4OVZmYkJiQXgvRmVDc3dTTnVyTzJaNXEvMVNW?=
 =?utf-8?B?L3hrV2tyMTB2d0dPYUVlMkdZWTAzcEEyVjlCa3VINDVtVnVKdWxSRjRHaFNY?=
 =?utf-8?B?aVYzUXFxRzY1aFhseThUK2tRL1lNWGJyUWQvdU5WQml1WXlPcnJRaVhRNTBB?=
 =?utf-8?Q?blooP3BeKjA8CuYjj7bmupNK2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iQYYmXXImbKW2XGVvPICjgOkuHQhQ11gX1LuTY1qAc/modjWRPttPx1nGueTB/nNNLJuU4OPy4AAE7FfB1VpGK+b16nODsStIWkCeiuborX6PIx7qxInKq14gxJIJkLfn1u61bXEnyNCsP90hC+qi2RxBDL4tjhsrG1pX2FUEY++4+GO9JRice3RsAqBEJBgQNhZtgMTQ4YHCXUZfXhjlKYTr/k7VhsTl6WM28dCJifQuuqXFk7UYpMyjbEuZ1dcUWXJ5hqgRINKLs4VVmY+QUEqHnUoSzGoza0OxgaAnaAtpPYrWihaYJMtwNeE1fOBXpgT7iBaAu5HFMP2V8yOzCgfg3zTQ2pCFw9iDpV5rrM7sGmK4xyFA0cxfnZ4sGekHgx+v7Cp/oORGHvEinipKh/A7MnpJlf0z9fLxbiwP069JnS+6FHfX65i51/3zqZizl8bXhePHTbepSZK3SA6nRvO06KpepN72C6BCA+Z4V0g3PsK+6y1bOX82aH1FxstSRozAmKUmCWLa2IFRa7XSXDM4a3O42p41OsybdtTb5XHS9lxeGkkwaoWg9Kz5xgx4UTqp3lvunNv8pL6AYpO8xPlaRFLovatGWPYcGc75eT5NTAWk7Bi4KFQryooC11L7bUzsFpVwegRWI7CiT2T5w==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8dd797-0538-4c0e-a150-08dce95cde22
X-MS-Exchange-CrossTenant-AuthSource: BY3PR09MB8834.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:53:45.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR09MB5351
X-Proofpoint-ORIG-GUID: PYw_hT1zEybj6HRDIOKpusHRAPrKUF9Z
X-Proofpoint-GUID: PYw_hT1zEybj6HRDIOKpusHRAPrKUF9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_13,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=804 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100125

> I don't quite understand what the E1000 is and where this code runs.
> Since you have a DMI check for DMI_PRODUCT_NAME "VSSEP1EC", I assume
> E1000 is an attached storage controller, and this driver is part of an
> embedded OS running inside the E1000 itself, *not* on the system to
> which the E1000 is attached?

You can think of an E1000 as a standard rack mount storage server with 24
NVMe slots.  They are often used as Lustre servers.  The DMI check makes
sure the E1000 LED driver can only be loaded on E1000 boards.  The driver
is running on the main system (where Lustre runs) rather than a embedded
storage controller. The driver does communicate with a embedded
controller via IPMI to control the LEDs though.

I'm currently on baby bonding leave, but I'll try to implement your review
comments into a version 3 patch once I get back into the office.

-Tony

