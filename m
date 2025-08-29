Return-Path: <linux-pci+bounces-35071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F99B3AEF9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 02:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0231678A4
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 00:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B589F79CD;
	Fri, 29 Aug 2025 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z3RnXAds"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B610F2;
	Fri, 29 Aug 2025 00:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426391; cv=fail; b=L6BKHRf3q7p9XtLSPdviuHbLU1FEFOMSbKuJjhh6mrhzoi0waGPkhrsPFZlyRyIe8O+d4q0tm8dzahngDuh2Ljx8sSTnYsdHgmsL9EuDOH9ZUmkxwhAPKArkj1saTitWGuVnqLATZkglMzY1lyzeXUkr8uq44bkfWs2Zz/Y9FkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426391; c=relaxed/simple;
	bh=/Xo3BrrNOpetbgNS0oekxD0Wri83gWe4MUXz3Lfizvo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dXvsYhhld52pfRdFFYxdy4oaq5UqOFzTBjGItr5K0tbJ3X7CBp2yjyLwsMNOJNIBweDqbavjV9ihfvTXEQRuqd7t4M+DFuYY9DU0iCC7/HGUgvGgYf1JM80FKfWoCj+R4UL9ucnkjriO3MzLDjo9jVG5YyEgrIOQE0PDSOWUn9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z3RnXAds; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+ubLKdjfoxfrt2IDYMK3lsEzJnGRFaK5+9VQLE1AXUIKy0y5QWV3w832LerxM2Ve1QfFo+KWVh1/MbKWmckxFVChmnn2jNYYkAm76tym8UOt0orUOtL55TvAYQUM/72VTFYhvH2+sAMcPNC8daP58K5bWAl6MZMdCJ0btjSJnQU7gBC2n1ksEBpWNccvrZdS1dEqaxoaAJuKdjq7m+Q3t9/tTgUlZkUxq/H/9TeU7SX64ma/7yBPgo2Fd+aag8GHFvwKHASb17ODfyG8WoKEA3VeZbkV9fFmtXjkzRJ3utijMY0/kOrmOaP9ZDfodzXYAa8Ttj2MBaCX9t307jHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5csuDAYwMoupiruJeH6S7OYkc+M2eubQcdv36jKkzPo=;
 b=ISF1JTi5bo/+7jww7j1HiunuInzTK4YAd/C4hzGRttVGMONjLBlUHHYENXFnsJSoP53k7lx3rzAkJfM3KlBZujNPsJ7o2B1vdrWp+T0pMIm/Gubu6KB5GYRmJDGg0phrWodn/2u7kCFJKEFNxtl2KgoJ7FXjQjQ9NJf36pI3UCOs5tJaA2dHtrjtME58BUGLumDHXvYjpwCLIUjtcDEoSSldrVwE8jjklXVgaOpDCWlD+c01VFB3+HW2BGckVK+E8w0fHpRT2ROdEFDvMoDjKFMyDfPQzKtlOSxcPYMXiMXkHf9Tnn+PyTzeIsv7vgLa72eSbDcvjuCqpTcv6erl/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5csuDAYwMoupiruJeH6S7OYkc+M2eubQcdv36jKkzPo=;
 b=Z3RnXAdscBn2riF42afkLnkWAX/uqfyVI2JBtrkcFuErK+naJUmAZBEi3HV1hvoyPKUk7CJ5Dlj7pcwzLfCAlRkpQFX5sD0t+jhADyvnZiD66kCF9I0E84Y5O+NsEACfgMykPTlGvyNl/Vly/hQPGKriORkm8KfqbFn+5hHHldBeXbQb6f6isVVHjbQAqM+zYk6MM3kY3yg0MKJDQSDgBiEHnZfIUdsiNKMVy0qAte9ebL94DZGve9SEVhV2UOSh6hAB43Isn7hu6esGCp5dSyIQoC/ciLjVFf+Sc+Ec4XE0c/BtcRFIg7qRztYTGNEepcOcqC6RF0+NyEbf/mxpGQ==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by MA0PR01MB9401.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.18; Fri, 29 Aug
 2025 00:12:58 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 00:12:58 +0000
Message-ID:
 <MAUPR01MB1107294E89F312A26812B9FC4FE3AA@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 29 Aug 2025 08:12:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, Chen Wang <unicornxw@gmail.com>,
 kwilczynski@kernel.org, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, arnd@arndb.de, bwawrzyn@cisco.com, bhelgaas@google.com,
 conor+dt@kernel.org, 18255117159@163.com, inochiama@gmail.com,
 kishon@kernel.org, krzk+dt@kernel.org, lpieralisi@kernel.org,
 mani@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 robh@kernel.org, s-vadapalli@ti.com, tglx@linutronix.de,
 thomas.richard@bootlin.com, sycamoremoon376@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, rabenda.cn@gmail.com, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1756344464.git.unicorn_wang@outlook.com>
 <1df25b33f0ea90a81c34c18cadedd38526a30f01.1756344464.git.unicorn_wang@outlook.com>
 <08d79767-4b9b-41c3-8d51-5ff879eacb31@oracle.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <08d79767-4b9b-41c3-8d51-5ff879eacb31@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <6ce590d9-d8ad-45f5-89fa-f9d36bdd2ed3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|MA0PR01MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e9691d-e9d8-4885-1ade-08dde690ce77
X-MS-Exchange-SLBlob-MailProps:
	rYPt1fhvLTUem4+YyY73AGh/GMpkrRb3eiSMrFOydFCTSkgdpCU1WMDbc8VU7htQEnDJ1iJH+1dHm6XJrk3J+gzDUMfas3AAvLbwMFevLToEuG6yDWhvXGd70VDGnqBTFI3F7QXJ2QHXC/+9iOtAnH+1wjf7eEDYjlIvayP5LBHObUR9N2ApgdjC3NpNF7hexJIH5zAQXCOd0d4yfnnOSLHCWd7Ms+8hJMUxxE/ZU+xx8mIQqs97ThPlNV5dWQDra2E2b+CzarSvq8Bxo8hvHjlPh3SmcK1DtGTkiU42Eu+306Z6qrvBzaerpYHmJ+FN+7FYYJ3qt4AZWBI0THzQg3RkqEyDyb4DFsSLUGDk+Mibty1eHoY+wbayYF2CFq7jK5bbcdhdRCZpjj5EIDCSgKCGBFvrvqUJXiif958m02wO99Paepenm2M3veUdicRRkq9qPEb/Xe2xxJn0Z0RSHdd6uLBKtDE+5/GWpNeKfpGgig3XnVh1fOe94iShJAu2zNfygl0RwnTMCFT877lUrKk+H3ZO5AmRb/kdP1zzQm3EXYR3UQfAgaAaNuDFgaiMHMUcQoL5KRHPL+1/SgQP3l53KiAt/IRtWbb73WrpYv7tz71oiaba0HQ1seoxtrcxwN+1I8bDubFzc2Y5mbMz2JfhI9qJMMGkUgdgxCwkwfRHdWagreGdP8EFSFB0R+wLpK6IrExd7nNdOaOhG5151Q==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|461199028|15080799012|5072599009|8060799015|19110799012|6090799003|41001999006|40105399003|39105399003|440099028|3412199025|41105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHRwWC92ZW5XZFJiZmJFVnBYZFpMQ001eHcvdWhpU29FNm4vRld1Y2tBRzh6?=
 =?utf-8?B?TUhxS29Id24xcHErRlBJT1BiOVprR01ETjRLa0xQK2dCR0hpNitCMmRLZi96?=
 =?utf-8?B?elZwMTBXSlc5MUpURkxRZ2ZDa0hNS3RyVWRYdjNIK01KVVpRZG93L1BySlJF?=
 =?utf-8?B?S1JIbUN4N3JNTXltbHBRYm1mbVdRcTJpa05lUlVmR0o4b2lFUkNTY3Mva3JI?=
 =?utf-8?B?T25KZ0tiTTF0RlFFNDRFUHlWclNkRUFXQWNxR3pVVjZOdG5qcjdwNTc4NVll?=
 =?utf-8?B?a3duWVc3UWh6bkRGK1dYY2FyZW5pMEVVWTVDVnhOWkNLK3JpN2F6REx4S0Y1?=
 =?utf-8?B?dFdaY2l0cWdMV1M0bHhhbnNydlBQNmFDVjFWYklVQW9lVUNrSWc4WVZaMStC?=
 =?utf-8?B?TEw4NlRqVzJqNDQrV1hsNTRPMm5oRXI1UFJCd2VJVmR3cnp2dEVzMldjS1Qy?=
 =?utf-8?B?elZhZFJsNDZaTVE3S3F0eVdEcThVMk1zRmVmbG9vYnk4SmhpY2Rmbzhmd0FH?=
 =?utf-8?B?ODVzSDNXMitWazBzalVVclpKeDVwSXREV2VMWmFBb2lGVHVpaGlycXU3MFkr?=
 =?utf-8?B?aGRxZWswcFlPUTBUd04xS3JnemJkcmlZOGxmYUpjNFhNSW9NSzlHemZPZm84?=
 =?utf-8?B?K0hCRkVuQUVONDZxeHhsTERGK2w2RzFDZzg2R1hDVnBSNi9NbHh6OEZiQWd1?=
 =?utf-8?B?aW4wWjBhYnMxVkJVL09oMEpxbXJTRmQ3SVo4Qk1TdERUTHdtc1BXVmh5clFj?=
 =?utf-8?B?bDlFMmwvRVBueXhOdXdBRHdVZWVYeEx0WjgxWnQ4V2t3N3U5RmJiYkVGWU5R?=
 =?utf-8?B?aGtHMmd0dEZMVnB2SmpUZnVJRGs2MkxWR1hIQjJTYVlBLzg0NUR5T0dpZ2ps?=
 =?utf-8?B?aW1ScndYeU5SRkdyVVl4dzdWWWdQZHdvOWQxUnloVDNIaEVNU0ZBOGRnMTQ5?=
 =?utf-8?B?UGdlUDZwVjJPZ3l1R3hVejVyOWNsWXRWeGtBbHg2djVTNWJ3aUQxT3o0bzAz?=
 =?utf-8?B?K2JrZ05HelE5cmhLeU5JTmNudjdacUt1NGxHTFhuaXgwcmV0QTFtYnlLVGYv?=
 =?utf-8?B?R2t5dTFmQ2doQ3FKcGhreUg2MjVIQU81Q1pUTWlHM2tIMWZUeWlud2ozeUZG?=
 =?utf-8?B?MDZ5RlFpRUVvOFVMeG00Yk9nREEwSEROZzNDNmlpaEJCQU03S1V2WTM0YklT?=
 =?utf-8?B?SEZESTZ6cTFjK3FtSEx3ZGlRTkdla0dYcU9aeEZXbEdTQ0ZpZHJzWVRwODJZ?=
 =?utf-8?B?bjZBMnlpR1kya3Vhektkby9jWlNVWlROdUpRelc1RFZ4am4wYUFaUllzNjA4?=
 =?utf-8?B?QVgrdnpiaHBlVEVxSHNackVPMVFwRFhEZHVwUlBJQlRkMktXMnJKNWpXdlUx?=
 =?utf-8?B?TVFQUFZrd0g2cDlCRkpXTnkxRUxmYkRlWFBrcGhxUjJrYmY4L2ZEOUU3WStR?=
 =?utf-8?B?TmwvNVhucnlUWDZZbndUaVdVY2g0eVRnVEZtZU1PNTFkTXJCVUJQcUU1VEpV?=
 =?utf-8?B?dG0rY050c0M3VDg1aW1IcytYbHFLTjNPdUh4MTA4K3BBTVRkQm9UUm5UNmhv?=
 =?utf-8?B?ajNGdkpzMkpqNUxObjVwN3dQMVhpbXpCbjJSTUhRVTErbkZMdFFnRjlESVd3?=
 =?utf-8?B?TXlyZTNHdXcxZUhpZ01zd0ZPQ3RjN2VFb0ZjVmQ0aHJoM2V0R3lVdEJaNHRa?=
 =?utf-8?B?ckdnbkdKTmJyS3dSOXJWY05HZWFGRlYvekdLSUFQcUIzUXJ5M09WUGN3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFFwU216aUZUUVZyT0pMdjVXUkNxdVVKbFpJbmtRd2xsRUhFNFRMWUhleElL?=
 =?utf-8?B?eXVWVms4M1JkVDlHcFI4SXFOUVgwUE5Ha0UzRnZESnRjYWpZQStmMXZWcjkw?=
 =?utf-8?B?QkZweWtrK3pyRVJYdGMxUmR6Z3NQbFhwbURxYjY3WW1IOEpPVWtZU2JBT052?=
 =?utf-8?B?SHg5VmNRT3I4M25QOTZkRjNWQXo0eTNsMlZ6QzIrSnNFekFCRHk4Z0RyemVh?=
 =?utf-8?B?VWpLRTlvMG96c1BtNllrb3NiY3VManF4UUtrY3YreE5ocVFRWC9ieDNmVXJU?=
 =?utf-8?B?QWxzdzRHRXNqY1FWdGRtaG5Nakp3QVVYL0xYbklxSThPRDMwM2JmQ2dBOWV2?=
 =?utf-8?B?TzJ4Smg5clJXRXQ4TzZXSEUrS3p1NWpDeDBDaFFTWHJsa0FOUjNNNVRIV3di?=
 =?utf-8?B?OW0rVmVhNFJmRVNFd1ViS25uckxFbU1DVW50RzdNNklaeldpUHdPd0lrT29a?=
 =?utf-8?B?VXdmUXBKWG54cUtNb2dLM3dROURIWHhFUFJCRmJESCt6Q3ZzYWdwTUNrSjhp?=
 =?utf-8?B?b3dVcDNsUmdoN3cySy9lK3BYU1FxdmdoZ2d4Si9YdTBnZ3JBR2RNMWdUUkd3?=
 =?utf-8?B?RUh0cmxQOHlFMlk5MWpZT3VJaDRKbytYdXBrTmMwc2ZZdE9DUDI5Zkd0aFdZ?=
 =?utf-8?B?QnpEeVJOWkYyQjgrYkhOUFdFbTlLRFZCczRDSEN0eEhJdGpkSWV5MGhaUkM4?=
 =?utf-8?B?M0NnSTZGM0NxU0xKaG9vYWcxeXVJWXpDemJSMWVVMjB3S3lZQW13ZHVZN1Zt?=
 =?utf-8?B?eUNrUC9MWUNDeFJFR2tMbHlSekRqUVM4WXRRejVyWWpxZ04rRHpQZ2FXdEVW?=
 =?utf-8?B?ZTBEVXlrTnlZQXRzRzNaRTV3Nk5kWWZKb1BCVUxHaGtPOVR1ZEw1TVVsdXhM?=
 =?utf-8?B?NUYwTWFiWWdvdmxZUGY0RXlaREVXV3dBbUQ2eW1TSXVhSmZKS3o1YXkydkND?=
 =?utf-8?B?cStaSnM3MFVHdUVLaGxHMUFJMnZjbHdML2NtNnM3UU4zY0FNVmdrMkNzN2pL?=
 =?utf-8?B?eldENURoUFllQmJPYkVneTBvZTQyaGk5T3dLWnhsa1NNdWg3WURyTDlVM2NM?=
 =?utf-8?B?OUYrS0RDMkhIcTdJTzViRXFHRWdINC93UTNuVFhmUC9YaW04RFEwOHl1SXht?=
 =?utf-8?B?d0ZoVXJiTnZIdHBsNXlXWWxSbEhwb2o3T1dYbkliaEpzVW1IbXdwZWZaVTRz?=
 =?utf-8?B?THBmV0JGUXA5Z01xNnpYUWR2T2cwUjYvNTNOQkt4YUp1amQ3V2tEZUhJMUVj?=
 =?utf-8?B?SzE3aVVCZDN1TncrZXNCSURxTUZ0RHYxYzB6YVBOZmhPYnRYc1g3bTZIMzll?=
 =?utf-8?B?ZnhYT1pIaDFLdnRQOERKbjhVMHVxcWp4MVdWWHZzQmE2ZGI4NGc2M1ZaVXhD?=
 =?utf-8?B?Wkw1YjJvYnUwWlcwU0w3M2RDZnBVTCs0dEs2bDJpNUVSWVFWS1RoaE5yUlls?=
 =?utf-8?B?dlNETDRQcmIrNzArWndPd2RDOHEybHExbkNIRUgvYStEUXNURDlLcDhrK3FV?=
 =?utf-8?B?eW9xNFhOWDJZOHNPTElLMFFCcjVqdW1rTGR4Y2xjV1BsRnM1aGkyNm96SXg0?=
 =?utf-8?B?OWhSa1VIS1N2NXVzWXh6a2ZDZ25mSFpBSk5IR1dVeXNmTlM4N2tVd2ljK1hr?=
 =?utf-8?B?dWVCM013K09mamF2aTY3OS9vVXF6ZU9SU0Z1dnk3ZHBOWU1tcnk3T2dzbzlV?=
 =?utf-8?B?d2pIUExmem5iUjhGa0lJdUFob2RMZ012TkgxaXpHZkthNE04Z2wreGpwZFFD?=
 =?utf-8?Q?Ig+IftEj539nRfsjEY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e9691d-e9d8-4885-1ade-08dde690ce77
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 00:12:57.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9401


On 8/28/2025 7:18 PM, ALOK TIWARI wrote:
>
>
> On 8/28/2025 7:47 AM, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
[......]

>> +
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#include "pcie-cadence.h"
>> +
>> +/*
>> + * SG2042 only support 4-byte aligned access, so for the rootbus 
>> (i.e. to read
>
> support -> supports
Nice catch!
>
>> + * the Root Port itself, read32 is required. For non-rootbus (i.e. 
>> to read
>> + * the PCIe peripheral registers, supports 1/2/4 byte aligned 
>> access, so
>> + * directly using read should be fine.
>> + *
>> + * The same is true for write.
> [clip]
>> +static int sg2042_pcie_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct pci_host_bridge *bridge;
>> +    struct cdns_pcie *pcie;
>> +    struct cdns_pcie_rc *rc;
>> +    int ret;
>> +
>> +    pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>> +    if (!pcie)
>> +        return -ENOMEM;
>> +
>> +    bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
>> +    if (!bridge) {
>> +        dev_err(dev, "Failed to alloc host bridge!\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    bridge->ops = &sg2042_pcie_host_ops;
>> +
>> +    rc = pci_host_bridge_priv(bridge);
>> +    pcie = &rc->pcie;
> First, pcie is allocated and then reassigned to &rc->pcie,
> which makes the initial allocation effectively leaked and unnecessary.

My fault.

Thanks,

Chen

[......]

>
> Thanks,
> Alok

