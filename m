Return-Path: <linux-pci+bounces-16324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BC09C1CBF
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 13:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA0DB22F33
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE61DED55;
	Fri,  8 Nov 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="QmF1WEet"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227A7B3E1;
	Fri,  8 Nov 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068266; cv=fail; b=Nztj1DhNO0qUKhqlYeYrkPXmLEhrBLtS+VkbrA6q3wCWb8Ayt+cvbE7sR4P0BcEMf/59kCtAxL29yThGmudaSCfsETa2qyY4cLVilyvbCcgwnt5RFET+SbgiGm1s8Ay441XRLNrNjzVLMzlBW8LHbgMoypO4gyRbVbAyjdV3Qb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068266; c=relaxed/simple;
	bh=hp1GB4+mJ1MPz7ZThYQqGrFIYDtaoNJNRKWsp9CQ9Ng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ALDF3f/iTNUMtzwsDecRQd1LXauwO0Mlq7G4N4WtQZK8ZX23uoCXzCTYCZdgxCwJqNktOlSlaPKQtqdkdUSjjqUBZD/Uzld/2nd2gNyGrwgqua31CNnt0Obd/04jreDtJ4G5l11+Jz10s/XeWiTzC1HJ5hZw7wzZ5SLytkylSP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=QmF1WEet; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A84Cmuf026047;
	Fri, 8 Nov 2024 04:17:26 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42sbdq0vmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 04:17:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HERa8HEeTF8eIEm+xqzqEDp6kodPBCMxEnh7z5w1zwcgqenH4YDzcndqbWSfbSdSWyOAZzu++1dI4ImpCds2MyigzSqjgR5FpHmcaqYEcL6cgSiOImODHxEAFtVK1Prv7neKMhobggcdQlDHJkibqS104n4fW7f0LAAPugO8K6gAra5nAJWDTLh5XSy6CRjn1L2RXqEATulUUUOgXmMDb6nIZrRcHmdbDJZCZ7GtFBP1HbQZ5IqL4+zWvSy1nu8AOgJFr+Fpp9lKxboABZEVGHU5re7egBqdN9sD32gp+ME9HMAFk7eIqFUxpj1kIuUGcI4fwpc1PH/by3fq2Idiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp1GB4+mJ1MPz7ZThYQqGrFIYDtaoNJNRKWsp9CQ9Ng=;
 b=dAKs02ryMTF3iVE3z9HrXqn8V1NbNA4BolR7fZQxg4s7MSHgOCx2d3HBWWzCPak6NZACaAmSIqfhwt856dhydALW//HW7foJAnGiWqbGIho710lGDQ8FLwqdfIquLmHVdWITKTpqHEni1+44ixqGbm6eH0v36WVFyTeqNEMqoOU8po/AmeDEDNG8HMJyCRv24TevCP6yF9hlak9BIm8sYrnw1WSr2aCyuspV4yRBHDtOkAxNM1FC0lMqpCHFLopipVtBTokqgASRHWcbz0Xia2asftOZqhcuLlPDbKk4kySpK0iviv6xe8nVZnK7mrAW7OwnXrjlLrYUp6Afwf9moA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp1GB4+mJ1MPz7ZThYQqGrFIYDtaoNJNRKWsp9CQ9Ng=;
 b=QmF1WEetHcC3kIzmXpRmYts4sIb2tdsAAaSK9XvhEWH1W9B1YmRJwg4CTUECiso0TG/yadLFG5G6Q40ZuLEUanFiqquF4gc4MM4TkpugeumZtFl1C2VvQ78ndxSTfPsUnhqB8dzhvZXGZbuffXGAyZQBJCv5qa+iyO18oRgysXU=
Received: from SJ0PR18MB4429.namprd18.prod.outlook.com (2603:10b6:a03:37e::12)
 by SJ0PR18MB3930.namprd18.prod.outlook.com (2603:10b6:a03:2ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 12:17:23 +0000
Received: from SJ0PR18MB4429.namprd18.prod.outlook.com
 ([fe80::71f1:4209:b2f:e47d]) by SJ0PR18MB4429.namprd18.prod.outlook.com
 ([fe80::71f1:4209:b2f:e47d%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 12:17:22 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>
Subject: Re: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Topic: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller
 driver
Thread-Index: AQHbMdgqNQl++2CxAEq8/PlibIreng==
Date: Fri, 8 Nov 2024 12:17:22 +0000
Message-ID:
 <SJ0PR18MB44293B3E1A4860D44DD5CD8FD95D2@SJ0PR18MB4429.namprd18.prod.outlook.com>
References: <20240826104531.1232136-1-sthotton@marvell.com>
 <20241107203252.GA1623581@bhelgaas>
In-Reply-To: <20241107203252.GA1623581@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB4429:EE_|SJ0PR18MB3930:EE_
x-ms-office365-filtering-correlation-id: cdedae02-7768-42c0-90c7-08dcffef4cad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZThpamRhcTMvMWY4R1gySDJabnpOb05pZEpGclRIbmlBY2doUXA5T2NNTnNX?=
 =?utf-8?B?clljeUNZUGxsaWpSaFJKNVY4NnlLcytWUTNTR21OQUVDTWxtMnRvVm12c0JY?=
 =?utf-8?B?YXJVNjFkSklXeGMzZExvNlJMQWFOWmpoYmw5QXRYYlpOVVlxaldtUUlwMjY3?=
 =?utf-8?B?a29JaC9CU053dHExbUw4bW15d3JVeUtLaFljbG95TnFlSEhtQ0lQTzFPVXVF?=
 =?utf-8?B?VGF0d0FWbTcyY291VzZMQXJiM1UrVDREWXk3RnZHOEZTclhUQ3JBUktKV2hQ?=
 =?utf-8?B?MGN0Mmh6UGk5bUFzOTdsSXN0a3ZjajRieVlPeVNOU1BXcVFpdTVxUDkvbUdF?=
 =?utf-8?B?b3VwNnh3Q21tSk5qRVNXdC92K1RkeWRJNEJlRGNNWkl2YjJjSmU2OFRQbzF6?=
 =?utf-8?B?by9sYllTMTROSDZYU1FUbDlJUDJidDhJaXB2OGEvT05Bejc2T1oyR1Jla0lW?=
 =?utf-8?B?U3E4Q0gwVzliQkxIVFAxSUlobnpTc1FkdGd3M0J1Tmw0UFFXWnlLRm52b0Vl?=
 =?utf-8?B?OXNub1BrcCtkQ2NKdDVRdHZHbFN1VnBhV1EybjlGTXNkdWE3cE1PNkY2UFNt?=
 =?utf-8?B?S05nUzF5emVjdTFUblgvRS8ySFRzaE9ZSGtPcXNtM3hUUm1CUDQ0S1loT0Zm?=
 =?utf-8?B?SDZObW9WVjZoZ09zY0NtN3kvd1o2aHc5Z2FLa29jbFUwKytkV3RIRzA2SGRB?=
 =?utf-8?B?YUFRMTY3YWFxQ0xvQzVBc01LbTJSU0pTVDdyb2haK1VtUWhSQU11eTZNdDlj?=
 =?utf-8?B?ZzFsNFpwNkNIZHpyZWl1Y2w0TmxndnV2NDVJRkE4amdERUlxVndTQzY0YzFj?=
 =?utf-8?B?UEhiTkpWSXdudC9sc2lCZDR4WmRKNTY0Rk1URjdlZ2Z5cTVNNmtKRjJpb3Qy?=
 =?utf-8?B?RUNabTFpN2ZHTmF3dUthUlM3N0VKSllFVmU4V2FsU1dXSU91bXMxSWplemNj?=
 =?utf-8?B?OTZBcmtzTGJzMUloRVorV1EvSS91ZnVHVk44Tng0K1FjSzRnWEZ4R2xhcENs?=
 =?utf-8?B?UkNPaGxUdVpNZlIzUmU4OVJiNk5JeFFxTlp6TFJqRHNLVE5aNU9FTXhxemxQ?=
 =?utf-8?B?UThiZGxNcTR1eDBYMmtiOWc1MzBkUUYzbGZRVnFNaDlPVDdRSlFiZTAzRk5u?=
 =?utf-8?B?VFVXNStWV3c1NHZKWVYydEpLazUvOWdZQkQraEp4WjRPUDNySzlwVmszSVBY?=
 =?utf-8?B?TE5wTWNOaXR3aGhwczZIUFRQdlZKdnBmamp5MW9aL3NuRVMwVjFtcDVFQlRK?=
 =?utf-8?B?UzMreTI4MWJ1RW9SVU02Nk5SYWtKSFIxb0Q1Q3NoM0xTOHFYUE1xYmtCbi9U?=
 =?utf-8?B?RHNjbzByMjhXTmNtS2ZYS3RqcFZFVjlXZnA3T3hxclVVMEZXcFEzWXVGdlg1?=
 =?utf-8?B?UEdPMVB6ek9PeWIxL2xHYXkxQU9CVDRHS0tOYis5dHBZdy9IbVdCaGtxcHpm?=
 =?utf-8?B?eVdKdkMxM0tMVWFlbHBHczYyYXlNMklYeU5DREhkUThqZGErbm1uY0dRd09w?=
 =?utf-8?B?Z3RJTkd0SkFUN1RJeCtZUGtEekFLSklucGNIOUpKQlRKaVpjSFl2eFZZUGh0?=
 =?utf-8?B?MGFuckhERnpKSTRtNjk1TFVDZjN3K2tZV1FUMy9SUHN6NWdmU0U5blZHLy9m?=
 =?utf-8?B?Z1V6TEFjeDhhMGJ4bytwVmt2THRqQnc3WEt6QlRJT2Y5RUZiYW5zYUxGazRj?=
 =?utf-8?B?ZjdCV1hlNENuNE9Zb1htelEvakhIc1J4dEpQWENFQmJDSncyai96emYyRUJK?=
 =?utf-8?B?dCtmZy92V2o1aE1yRGJyMHJVUm4rYlZGM0ZHdTFacGZ5bHRBanYwTWhCcXdw?=
 =?utf-8?B?aGxHcHA3SnJHblVITTAycEFDK2xjSXBTR0F4MmZQaXpJWTU0ZFRMYytUQU5R?=
 =?utf-8?Q?inmJvnlhWnrAc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB4429.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFBXZk1Falg4UUdIbW1XOHU3djhjanJ5UWo0ODRzMlhHb1diUkVBQXlxRVhP?=
 =?utf-8?B?SmNLdUxJNHFlbVc1YnJtSzF0eFdWRXNJc25TWVA0bWhkbE5mdUtsWGYwTUVW?=
 =?utf-8?B?VlRDNEZ6a1lGV1d5Z2srUk1xTlZMRVZyVnJraUNzNms3aXdEWUxIWnByeWhW?=
 =?utf-8?B?aVlNRXpJR2xuK0djd3V5Q21aWGVONzBUU0pGQ096VGZRUzI3c1BZcXBkdEh6?=
 =?utf-8?B?WUQ1Wm9jMUNBakU0ZCsyTjJBSUxML2E2cGdzUlhiQjBKOXJDcnNZTkhXd3R6?=
 =?utf-8?B?SW1Lc3Q3NDB3cXJLV0JuSlBEc1dKdncrSnRQaHVzZ3ZGL1l1N1M1bkloU0FL?=
 =?utf-8?B?NVFvWWlmSVUyWUdOdktHK1NYUFlJYmtJNUtDblBMOUpxZTgycE5CeVM4dUlR?=
 =?utf-8?B?YVpVck54cXJ1UVpCZnI3U2xNSnlvckoxbGIrVkYweXBZY1FTYjVZSm1VUVV6?=
 =?utf-8?B?d2crYkZZMWkvUGRQMWRRQStkVkdGR3ZYQlRiL2U1SGZDNjVjeEpVdEIrOTlF?=
 =?utf-8?B?MzNhWEJSNFVDZm00a01IaEJ4NEJFYUJMTDBNWEhFenhpWkhReC9WdzhlQ2dl?=
 =?utf-8?B?a1FrcDdqaWRoVGpLRkY4d2hjSXlCWWgvMUl3VkVNWXVRNlNOZmpyVjV2Z01H?=
 =?utf-8?B?SGV1THJjVDJZd1I2WThqNU1DODk0bUZmY0NlTVM0WHR3eXgwZjZibEZkUGJ2?=
 =?utf-8?B?WXNDTHEwa3pMSXZZejhaWC9IenkveHNtTXJaM0dBb1hkSWpsaE5mVGh0QXJR?=
 =?utf-8?B?TGZmMHhwMmxVdHBta1Rwc0laczZzUFlUZWFkWTgvcDF6RHVGRHltVkZLU1BB?=
 =?utf-8?B?V2V5d2Vtb0wyejhsK0YvLy9nWXowZXBrU1RMRnhiSVFpd2pOREJFU200WjhE?=
 =?utf-8?B?TGtZdUdRclFVcnhPWWV1RUdNd0RDemtYVmN5MGpabnVQR3NjU3Q0T2ZFM1Bs?=
 =?utf-8?B?bHpRbk0rMlhBUStOM09KcnRjMVkrLzZobEZCeWdDc09mN2JkMzFESmNTaSt5?=
 =?utf-8?B?RzEyaDJYd0tQbUxRY0NIV2dBRkxIU285QlBreGREQzROSHgzRTBmbjlWY2c0?=
 =?utf-8?B?Tk5kTVlFM2ZzSllHOFFVVzVtSWdFYmZIQVZFYlJMbmF0TUdnZktRbkZaY1FX?=
 =?utf-8?B?YXl0bzAzdnYxbjJHOHpacWVZd0F4ckhFb25VbnhhVGhFQXE1MDBoS2tHdXB6?=
 =?utf-8?B?RHBYNS9PT1lCTzdOd1o3UHFsaElYZllvVUE3SENSYklGWEtDbFJXc3IyWVhH?=
 =?utf-8?B?SWJtWUw0TlR0ZUJGejVtNnhhT0x0R2N4Zmc4TWRNUGVxUHRiVGhNUFdsakJF?=
 =?utf-8?B?Slp2RmVrNTV4VW9rZ2dLelF2STBjdjFWWkdMMWdobjY2NHUyRTc2bC85aGV4?=
 =?utf-8?B?RUgwN0JVazVDRGtqWGdIL0picGkyWWVyRFErSU9kbWtoWjFaWjRjdDJNRlJG?=
 =?utf-8?B?UExmbDlpOEVvZXB3VHA1MmZxem1aK3ByRjd1Tk1qUElKU0hPWmhrbzA5VEVM?=
 =?utf-8?B?UTBpREsrdFQvOFd6QUZtOStHemlSbGpvZytVYUIyNVo1aUxjVDJIZ0VrOGVq?=
 =?utf-8?B?bU5zdVlpRVFsYzZLY1RncnFxRjEzWGZzQ2RrWHFnQlB0SklZUG5iN09oNEtS?=
 =?utf-8?B?ZGg2YlVSbE93bGM2a25ZMVdYTUNTekFvZzBsZjkyVkxNSkRXWDFaZG9TUUMz?=
 =?utf-8?B?aG4wOTE3eVNtY0VCWXZmd2k3dkNxNTY4NEhRRkN4STlMY0pvUWlVcmphSFN4?=
 =?utf-8?B?YXV0U1FsMkZmbjB0anFMZkllSStnQkJ2WUNxcGgveVh0NXl6MEIweStXay93?=
 =?utf-8?B?V2xycUdKaFUrQ01nQm1yYm9pUHJjNUFadklTa3ZVd2dJWDRjMHYvR3A1R3Mz?=
 =?utf-8?B?YjBBVkN4NnhzV1YzcTFveTRtd2dGdlBONitrZlFwaUx2YWFqMnowdktaKyth?=
 =?utf-8?B?Ymx2VzFJSkttdEFSOU9Ga1AzRjY3em52M3c0MytHZnY1WUZMM3Q5bTByczg2?=
 =?utf-8?B?eURtZ2dHcTY2SFlEK2dyclhvYUhzbjBwOHR3dWlmU0doSzBWcUQrTG9yb1I1?=
 =?utf-8?B?QlZvQnBuUm9UWVVRRUdFOVJwcXM1Nnc1SVpmUTA2WGxzdzdQL2ZKWUViTVh4?=
 =?utf-8?Q?wX5PJ1Cb9TptPlRIQD63eIADc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4429.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdedae02-7768-42c0-90c7-08dcffef4cad
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 12:17:22.8280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVc+VzHVd1J6XK64Oj5wP2t51gglc17dDq4XW1rLWZWJXAWpik/jHraSJs3pUnbSKH1JwaQrh9M1yJCFkoruaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3930
X-Proofpoint-ORIG-GUID: 7nkj0NOWfyQ_aZwyBWozLXMwuVneybJ8
X-Proofpoint-GUID: 7nkj0NOWfyQ_aZwyBWozLXMwuVneybJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Pj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgUENJIGhvdHBsdWcgY29udHJvbGxlciBkcml2ZXIg
Zm9yIHRoZSBPQ1RFT04NCj4+IFBDSWUgZGV2aWNlLCBhIG11bHRpLWZ1bmN0aW9uIFBDSWUgZGV2
aWNlIHdoZXJlIHRoZSBmaXJzdCBmdW5jdGlvbiBhY3RzDQo+PiBhcyBhIGhvdHBsdWcgY29udHJv
bGxlci4gSXQgaXMgZXF1aXBwZWQgd2l0aCBNU0kteCBpbnRlcnJ1cHRzIHRvIG5vdGlmeQ0KPj4g
dGhlIGhvc3Qgb2YgaG90cGx1ZyBldmVudHMgZnJvbSB0aGUgT0NURU9OIGZpcm13YXJlLg0KPg0K
PnMvTVNJLXgvTVNJLVgvIHRvIG1hdGNoIHNwZWMgYW5kIG90aGVyIHVzZXMNCg0KSSB3aWxsIGNo
YW5nZSBpbiB2NA0KDQo+DQo+PiBUaGUgZHJpdmVyIGZhY2lsaXRhdGVzIHRoZSBob3RwbHVnZ2lu
ZyBvZiBub24tY29udHJvbGxlciBmdW5jdGlvbnMNCj4+IHdpdGhpbiB0aGUgc2FtZSBkZXZpY2Uu
IER1cmluZyBwcm9iZSwgbm9uLWNvbnRyb2xsZXIgZnVuY3Rpb25zIGFyZQ0KPj4gcmVtb3ZlZCBh
bmQgcmVnaXN0ZXJlZCBhcyBQQ0kgaG90cGx1ZyBzbG90cy4gVGhlIHNsb3RzIGFyZSBhZGRlZCBi
YWNrDQo+PiBvbmx5IHVwb24gcmVxdWVzdCBmcm9tIHRoZSBkZXZpY2UgZmlybXdhcmUuIFRoZSBk
cml2ZXIgYWxzbyBhbGxvd3MgdGhlDQo+PiBlbmFibGluZyBhbmQgZGlzYWJsaW5nIG9mIHRoZSBz
bG90cyB2aWEgc3lzZnMgc2xvdCBlbnRyaWVzLCBwcm92aWRlZCBieQ0KPj4gdGhlIFBDSSBob3Rw
bHVnIGZyYW1ld29yay4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTaGlqaXRoIFRob3R0b24gPHN0
aG90dG9uQG1hcnZlbGwuY29tPg0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBWYW1zaSBBdHR1bnVydSA8
dmF0dHVudXJ1QG1hcnZlbGwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVmFtc2kgQXR0dW51cnUg
PHZhdHR1bnVydUBtYXJ2ZWxsLmNvbT4NCj4NCj5UaGlzIG9yZGVyIGlzIGluY29ycmVjdCBiZWNh
dXNlIHRoZSBoYW5kbGVyIChTaGlqaXRoIGluIHRoaXMgY2FzZSkNCj5zaG91bGQgYmUgbGFzdCBp
biB0aGUgY2hhaW47IHNlZQ0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mv
c3VibWl0dGluZy1wYXRjaGVzLnJzdD9pZD12Ni4xMSNuMzk2DQo+DQoNCkkgd2lsbCBjaGFuZ2Ug
aW4gdjQuDQoNCj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIFBDSSBob3RwbHVnIGNvbnRyb2xs
ZXIgZHJpdmVyIGZvciBPQ1RFT04gUENJZSBob3RwbHVnDQo+PiBjb250cm9sbGVyLiBUaGUgT0NU
RU9OIFBDSWUgZGV2aWNlIGlzIGEgbXVsdGktZnVuY3Rpb24gZGV2aWNlIHdoZXJlIHRoZSBmaXJz
dA0KPj4gZnVuY3Rpb24gYWN0cyBhcyBhIFBDSSBob3RwbHVnIGNvbnRyb2xsZXIuDQo+Pg0KPj4g
ICAgICAgICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+PiAgICAg
ICAgICAgICAgIHwgICAgICAgICAgIFJvb3QgUG9ydCAgICAgICAgICAgIHwNCj4+ICAgICAgICAg
ICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0ll
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+PiArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPj4gfCAg
ICAgICAgICAgICAgT0NURU9OIFBDSWUgTXVsdGlmdW5jdGlvbiBEZXZpY2UgICAgICAgICAgICAg
ICAgIHwNCj4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rDQo+PiAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICB8
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgfA0KPj4gICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgIHwNCj4+ICstLS0tLS0tLS0tLS0t
LS0tLS0tLS0rICArLS0tLS0tLS0tLS0tLS0tLSsgICstLS0tLSsgICstLS0tLS0tLS0tLS0tLS0t
Kw0KPj4gfCAgICAgIEZ1bmN0aW9uIDAgICAgIHwgIHwgICBGdW5jdGlvbiAxICAgfCAgfCAuLi4g
fCAgfCAgIEZ1bmN0aW9uIDcgICB8DQo+PiB8IChIb3RwbHVnIGNvbnRyb2xsZXIpfCAgfCAoSG90
cGx1ZyBzbG90KSB8ICB8ICAgICB8ICB8IChIb3RwbHVnIHNsb3QpIHwNCj4+ICstLS0tLS0tLS0t
LS0tLS0tLS0tLS0rICArLS0tLS0tLS0tLS0tLS0tLSsgICstLS0tLSsgICstLS0tLS0tLS0tLS0t
LS0tKw0KPj4gICAgICAgICAgICAgfA0KPj4gICAgICAgICAgICAgfA0KPj4gKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0rDQo+PiB8ICAgQ29udHJvbGxlciBGaXJtd2FyZSAgIHwNCj4+ICstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPj4NCj4+IFRoZSBob3RwbHVnIGNvbnRyb2xsZXIgZHJp
dmVyIGZhY2lsaXRhdGVzIHRoZSBob3RwbHVnZ2luZyBvZiBub24tY29udHJvbGxlcg0KPj4gZnVu
Y3Rpb25zIGluIHRoZSBzYW1lIGRldmljZS4gRHVyaW5nIHRoZSBwcm9iZSBvZiB0aGUgZHJpdmVy
LCB0aGUgbm9uLQ0KPmNvbnRyb2xsZXINCj4+IGZ1bmN0aW9uIGFyZSByZW1vdmVkIGFuZCByZWdp
c3RlcmVkIGFzIFBDSSBob3RwbHVnIHNsb3RzLiBUaGV5IGFyZSBhZGRlZA0KPmJhY2sNCj4+IG9u
bHkgdXBvbiByZXF1ZXN0IGZyb20gdGhlIGRldmljZSBmaXJtd2FyZS4gVGhlIGRyaXZlciBhbHNv
IGFsbG93cyB0aGUgdXNlcg0KPnRvDQo+PiBlbmFibGUvZGlzYWJsZSB0aGUgZnVuY3Rpb25zIHVz
aW5nIHN5c2ZzIHNsb3QgZW50cmllcyBwcm92aWRlZCBieSBQQ0kgaG90cGx1Zw0KPj4gZnJhbWV3
b3JrLg0KPg0KPkkgdGhpbmsgdGhlIGRpYWdyYW0gYW5kIHRoaXMgdGV4dCB3b3VsZCBiZSB1c2Vm
dWwgaW4gdGhlIGNvbW1pdCBsb2cuDQo+DQo+SSB3b3VsZCByZXBocmFzZSAiZnVuY3Rpb25zIGFy
ZSByZW1vdmVkIC4uLiIgYXMgInRoZSBkcml2ZXIgcmVtb3Zlcw0KPmZ1bmN0aW9ucyIgdG8gbWFr
ZSBpdCBjbGVhciB0aGF0IHRoaXMgaXMgcHVyZWx5IGEgc29mdHdhcmUgdGhpbmcgYW5kDQo+dGhl
cmUncyBubyBQQ0llLWxldmVsIGNoYW5nZS4gIFNpbWlsYXIgZm9yIGFkZGluZyB0aGVtIGJhY2su
DQo+DQoNCkkgd2lsbCB1cGRhdGUgdGhlIGNvbW1pdCBsb2cgd2l0aCB0aGUgZGlhZ3JhbSBhbmQg
bW9yZSB3b3JkaW5ncyBmcm9tIGFib3ZlLg0KDQo+PiBUaGlzIHNvbHV0aW9uIGFkb3B0cyBhIGhh
cmR3YXJlICsgc29mdHdhcmUgYXBwcm9hY2ggZm9yIHNldmVyYWwgcmVhc29uczoNCj4+DQo+PiAx
LiBUbyByZWR1Y2UgaGFyZHdhcmUgaW1wbGVtZW50YXRpb24gY29zdC4gU3VwcG9ydGluZyBjb21w
bGV0ZSBob3RwbHVnDQo+PiAgICBjYXBhYmlsaXR5IHdpdGhpbiB0aGUgY2FyZCB3b3VsZCByZXF1
aXJlIGEgUENJIHN3aXRjaCBpbXBsZW1lbnRlZCB3aXRoaW4uDQo+Pg0KPj4gMi4gSW4gdGhlIG11
bHRpLWZ1bmN0aW9uIGRldmljZSwgbm9uLWNvbnRyb2xsZXIgZnVuY3Rpb25zIGNhbiBhY3QgYXMg
ZW11bGF0ZWQNCj4+ICAgIGRldmljZXMuIFRoZSBmaXJtd2FyZSBjYW4gZHluYW1pY2FsbHkgZW5h
YmxlIG9yIGRpc2FibGUgdGhlbSBhdCBydW50aW1lLg0KPj4NCj4+IDMuIE5vdCBhbGwgcm9vdCBw
b3J0cyBzdXBwb3J0IFBDSSBob3RwbHVnLiBUaGlzIGFwcHJvYWNoIHByb3ZpZGVzIGdyZWF0ZXIN
Cj4+ICAgIGZsZXhpYmlsaXR5IGFuZCBjb21wYXRpYmlsaXR5IGFjcm9zcyBkaWZmZXJlbnQgaGFy
ZHdhcmUgY29uZmlndXJhdGlvbnMuDQo+DQo+VGhlIGRvd25zaWRlIG9mIGFsbCB0aGlzIGlzIHRo
ZSBuZWVkIGZvciBzcGVjaWFsLXB1cnBvc2Ugc29mdHdhcmUsDQo+d2hpY2ggc2xvd3MgdGhpbmdz
IGRvd24gKHlvdSBuZWVkIHRvIGRldmVsb3AgaXQsIG90aGVycyBuZWVkIHRvIHJldmlldw0KPml0
KSBhbmQgYnVyZGVucyBldmVyeWJvZHkgd2l0aCBvbmdvaW5nIG1haW50ZW5hbmNlLCBlLmcuLCBj
aGFuZ2VzIHRvDQo+UENJIGRldmljZSByZW1vdmFsLCByZXNvdXJjZSBhc3NpZ25tZW50LCBzbG90
IHJlZ2lzdHJhdGlvbiwgZXRjLiBub3cNCj5oYXZlIHRvIGNvbnNpZGVyIGFub3RoZXIgY2FzZS4N
Cj4NCj4+IFRoZSBob3RwbHVnIGNvbnRyb2xsZXIgZnVuY3Rpb24gaXMgbGlnaHR3ZWlnaHQgYW5k
IGlzIGVxdWlwcGVkIHdpdGggTVNJLXgNCj4+IGludGVycnVwdHMgdG8gbm90aWZ5IHRoZSBob3N0
IGFib3V0IGhvdHBsdWcgZXZlbnRzLiBVcG9uIHJlY2VpdmluZyBhbg0KPj4gaW50ZXJydXB0LCB0
aGUgaG90cGx1ZyByZWdpc3RlciBpcyByZWFkLCBhbmQgdGhlIHJlcXVpcmVkIGZ1bmN0aW9uIGlz
IGVuYWJsZWQNCj4+IG9yIGRpc2FibGVkLg0KPj4NCj4+IFRoaXMgZHJpdmVyIHdpbGwgYmUgYmVu
ZWZpY2lhbCBmb3IgbWFuYWdpbmcgUENJIGhvdHBsdWcgZXZlbnRzIG9uIHRoZSBPQ1RFT04NCj4+
IFBDSWUgZGV2aWNlIHdpdGhvdXQgcmVxdWlyaW5nIGNvbXBsZXggaGFyZHdhcmUgc29sdXRpb25z
Lg0KPg0KPj4gK2NvbmZpZyBIT1RQTFVHX1BDSV9PQ1RFT05FUA0KPj4gKwlib29sICJPQ1RFT04g
UENJIGRldmljZSBIb3RwbHVnIGNvbnRyb2xsZXIgZHJpdmVyIg0KPg0KPnMvTWFydmVsbCBQQ0kg
ZGV2aWNlL0Nhdml1bSBPQ1RFT04gUENJLyB0byBtYXRjaCBvdGhlciBlbnRyaWVzLg0KPg0KDQpD
YXZpdW0gd2FzIGFjcXVpcmVkIGJ5IE1hcnZlbGwsIGJ1dCB3ZSBhcmUgc3RpbGwgdXNpbmcgdGhl
IFBDSSB2ZW5kb3IgSUQgIA0KYFBDSV9WRU5ET1JfSURfQ0FWSVVNYC4gSSBob3BlIHVzaW5nIE1h
cnZlbGwgaXMgYWNjZXB0YWJsZTsgcGxlYXNlIGxldCBtZSAgDQprbm93IGlmIHRoaXMgcG9zZXMg
YW55IGlzc3Vlcy4NCg0KPlRoaXMgS2NvbmZpZyBmaWxlIGlzbid0IGNvbXBsZXRlbHkgc29ydGVk
LCBidXQgaWYgeW91IG1vdmUgdGhpcyBhYm92ZQ0KPlNIUEMsIGl0IHdpbGwgYXQgbGVhc3QgYmUg
Y2xvc2VyLg0KPg0KDQpJIHdpbGwgbW92ZSBhYm92ZSBTSFBDLg0KDQo+PiArc3RhdGljIGludCBv
Y3RlcF9ocF9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+PiArCQkJICAgICAgY29u
c3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQ0KPj4gK3sNCj4+ICsJc3RydWN0IG9jdGVwX2hw
X2NvbnRyb2xsZXIgKmhwX2N0cmw7DQo+PiArCXN0cnVjdCBwY2lfZGV2ICp0bXBfcGRldiA9IE5V
TEw7DQo+PiArCXN0cnVjdCBvY3RlcF9ocF9zbG90ICpocF9zbG90Ow0KPj4gKwl1MTYgc2xvdF9u
dW1iZXIgPSAwOw0KPj4gKwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwlocF9jdHJsID0gZGV2bV9remFs
bG9jKCZwZGV2LT5kZXYsIHNpemVvZigqaHBfY3RybCksIEdGUF9LRVJORUwpOw0KPj4gKwlpZiAo
IWhwX2N0cmwpDQo+PiArCQlyZXR1cm4gLUVOT01FTTsNCj4+ICsNCj4+ICsJcmV0ID0gb2N0ZXBf
aHBfY29udHJvbGxlcl9zZXR1cChwZGV2LCBocF9jdHJsKTsNCj4+ICsJaWYgKHJldCkNCj4+ICsJ
CXJldHVybiByZXQ7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIFJlZ2lzdGVyIGFsbCBob3RwbHVn
IHNsb3RzLiBIb3RwbHVnIGNvbnRyb2xsZXIgaXMgdGhlIGZpcnN0IGZ1bmN0aW9uDQo+PiArCSAq
IG9mIHRoZSBQQ0kgZGV2aWNlLiBUaGUgaG90cGx1ZyBzbG90cyBhcmUgdGhlIHJlbWFpbmluZyBm
dW5jdGlvbnMgb2YNCj4+ICsJICogdGhlIFBDSSBkZXZpY2UuIFRoZXkgYXJlIHJlbW92ZWQgZnJv
bSB0aGUgYnVzIGFuZCBhcmUgYWRkZWQgYmFjaw0KPndoZW4NCj4+ICsJICogdGhlIGhvdHBsdWcg
ZXZlbnQgaXMgdHJpZ2dlcmVkLg0KPg0KPiJMb2dpY2FsbHkgcmVtb3ZlZCwiIEkgZ3Vlc3M/ICBP
YnZpb3VzbHkgdGhlIFBDSWUgTGluayByZW1haW5zIHVwDQo+c2luY2UgZnVuY3Rpb24gMCBpcyBz
dGlsbCBhbGl2ZSwgYW5kIEkgYXNzdW1lIHRoZXNlIG90aGVyIGZ1bmN0aW9ucw0KPndvdWxkIHN0
aWxsIHJlc3BvbmQgdG8gY29uZmlnIGFjY2Vzc2VzLg0KPg0KDQpZZXMsIGl0J3MganVzdCBhIHNv
ZnR3YXJlIHJlbW92YWwuIEkgd2lsbCB1cGRhdGUgdGhlIHRleHQuDQoNCj4+ICsJICovDQo+PiAr
CWZvcl9lYWNoX3BjaV9kZXYodG1wX3BkZXYpIHsNCj4NCj5VZ2guICBXZSBzaG91bGQgYXZvaWQg
Zm9yX2VhY2hfcGNpX2RldigpIHdoZW4gcG9zc2libGUuDQo+DQo+SUlVQyB5b3Ugb25seSBjYXJl
IGFib3V0IG90aGVyIGZ1bmN0aW9ucyBvZiAqdGhpcyogZGV2aWNlLCBhbmQgdGhvc2UNCj5mdW5j
dGlvbnMgc2hvdWxkIGFsbCBiZSBvbiB0aGUgYnVzLT5kZXZpY2VzIGxpc3QuICBUaGVyZSBhcmUg
bWFueQ0KPmluc3RhbmNlcyBvZiB0aGlzLCB3aGljaCBJIHRoaW5rIHdvdWxkIGJlIHN1ZmZpY2ll
bnQ6DQo+DQo+ICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGRldiwgJmJ1cy0+ZGV2aWNlcywgYnVzX2xp
c3QpDQo+DQoNCk9rYXkuIEkgd2lsbCByZXBsYWNlIGZvcl9lYWNoX3BjaV9kZXYoKSB3aXRoIGxp
c3RfZm9yX2VhY2hfZW50cnlfc2FmZSgpLg0KDQo+PiArCQlpZiAoIW9jdGVwX2hwX2lzX3Nsb3Qo
aHBfY3RybCwgdG1wX3BkZXYpKQ0KPj4gKwkJCWNvbnRpbnVlOw0KPg0KPldoaWNoIHdvdWxkIG1h
a2UgdGhpcyBjaGVjayBtb3N0bHkgdW5uZWNlc3NhcnkuDQoNClllcywgSSB3aWxsIHJlcGxhY2Ug
aXQgd2l0aCB0aGUgY2hlY2sgYmVsb3cgdG8gc2tpcCB0aGUgY29udHJvbGxlciBmdW5jdGlvbi4N
CiAgaWYgKHRtcF9wZGV2ID09IHBkZXYpDQogICAgICBjb250aW51ZTsNCg0KPg0KPj4gKwkJaHBf
c2xvdCA9IG9jdGVwX2hwX3JlZ2lzdGVyX3Nsb3QoaHBfY3RybCwgdG1wX3BkZXYsDQo+c2xvdF9u
dW1iZXIpOw0KPj4gKwkJaWYgKElTX0VSUihocF9zbG90KSkNCj4+ICsJCQlyZXR1cm4gZGV2X2Vy
cl9wcm9iZSgmcGRldi0+ZGV2LCBQVFJfRVJSKGhwX3Nsb3QpLA0KPj4gKwkJCQkJICAgICAiRmFp
bGVkIHRvIHJlZ2lzdGVyIGhvdHBsdWcgc2xvdA0KPiV1XG4iLA0KPj4gKwkJCQkJICAgICBzbG90
X251bWJlcik7DQo+PiArDQo+PiArCQlyZXQgPSBkZXZtX2FkZF9hY3Rpb24oJnBkZXYtPmRldiwg
b2N0ZXBfaHBfZGVyZWdpc3Rlcl9zbG90LA0KPj4gKwkJCQkgICAgICBocF9zbG90KTsNCj4+ICsJ
CWlmIChyZXQpDQo+PiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwgcmV0LA0K
Pj4gKwkJCQkJICAgICAiRmFpbGVkIHRvIGFkZCBhY3Rpb24gZm9yDQo+ZGVyZWdpc3RlcmluZyBz
bG90ICV1XG4iLA0KPj4gKwkJCQkJICAgICBzbG90X251bWJlcik7DQo+PiArCQlzbG90X251bWJl
cisrOw0KPj4gKwl9DQo+DQo+QUZBSUNTIHRoaXMgZHJpdmVyIGxvZ3Mgbm90aGluZyBhdCBhbGwg
aW4gZG1lc2cgKGV4Y2VwdCBmb3IgZXJyb3JzIGFuZA0KPmEgZmV3IGRldl9kYmcoKSB1c2VzKS4g
IFNlZW1zIGxpa2UgaXQgbWlnaHQgYmUgdXNlZnVsIHRvIGhhdmUgc29tZQ0KPmhpbnRzIHRoZXJl
IGFib3V0IHRoZSBob3RwbHVnIGNvbnRyb2xsZXIgZXhpc3RlbmNlLCBwb3NzaWJseSB0aGUNCj5j
b25uZWN0aW9uIGJldHdlZW4gdGhlIHNsb3QgbmFtZSB1c2VkIGluIHN5c2ZzIGFuZCB0aGUgUENJ
IGZ1bmN0aW9uLA0KPmFuZCBtYXliZSBldmVuIGhvdC1hZGQgYW5kIGhvdC1yZW1vdmUgZXZlbnRz
Lg0KPg0KDQpPa2F5LiBJ4oCZbGwgYWRkIG1vcmUgaW5mb3JtYXRpdmUgcHJpbnRzIGFzIG1lbnRp
b25lZCBhYm92ZS4NCg0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArI2RlZmluZSBP
Q1RFUF9ERVZJRF9IUF9DT05UUk9MTEVSIDB4YTBlMw0KPg0KPkV2ZW4gdGhvdWdoIHRoaXMgaXMg
YSBwcml2YXRlICNkZWZpbmUsIEkgdGhpbmsgc29tZXRoaW5nIGxpa2UNCj5QQ0lfREVWSUNFX0lE
X0NBVklVTV9PQ1RFUF9IUF9DVExSIHdvdWxkIGJlIG5pY2UgYmVjYXVzZSB0aGF0J3MgdGhlDQo+
dHlwaWNhbCBwYXR0ZXJuIG9mIGluY2x1ZGUvbGludXgvcGNpX2lkcy5oLg0KPg0KDQpUaGUgc2Ft
ZSByZWFzb24gbWVudGlvbmVkIGFib3ZlIGZvciBub3QgdXNpbmcgdGhlIG5hbWUgQ0FWSVVNLg0K
SXMgaXQgIG9rYXkgdG8gdXNlIGBQQ0lfREVWSUNFX0lEX01BUlZFTExfT0NURVBfSFBfQ1RMUmA/
DQoNCj4+ICtzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQgb2N0ZXBfaHBfcGNpX21hcFtdID0g
ew0KPj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9DQVZJVU0sDQo+T0NURVBfREVWSURf
SFBfQ09OVFJPTExFUikgfSwNCj4+ICsJeyB9LA0KPj4gK307DQoNClRoYW5rcywNClNoaWppdGgN
Cg==

