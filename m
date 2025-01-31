Return-Path: <linux-pci+bounces-20586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46625A23D63
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 12:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5333A5AD2
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C8E1898F2;
	Fri, 31 Jan 2025 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="fqeK6Ckr";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="PS/Xe8cX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36A2AD11;
	Fri, 31 Jan 2025 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738324767; cv=fail; b=pTVMGmgfXNeLmWakQLcQCHczV2qF5hrTMW1oWdDPlxoG3abIuyB1hSBTQEMjTgPdnHb+iHe1FCtx1yOs9wl3kabPMV9uVSTs6Rb3Yl9NxREclB2hnO6l0a+ePMg05BYTZthxMQQDonLQX4pPqmRQpyApQNW33EaP1dvIEfEVOgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738324767; c=relaxed/simple;
	bh=ULmbNmqQ75iLPCf3Na1MmXbC13XpL9U/wChaBkZVWn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pJ9s4FK17X7o6hkGj6NRw1P0eKPOVrrD7sQHdT1ILHuU8YbR7TMfkXioi2YtUPoDJ4aaD3INn+xw3s98aMNKjNgtt83I+3zXu3T2wo5+vTjVSQgDV2YL8IEb3eNoxR/t1nhSESo505K4JWq0KcPH8jZ3bL20pRFPyehrtW01KCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=fqeK6Ckr; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=PS/Xe8cX; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V7qfFr029472;
	Fri, 31 Jan 2025 03:59:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=9Fe2qYBXwLDQ275Cq7peL0lmEfWYUB89oar8hKOO85A=; b=fqeK6CkrbwPF
	fPjFxMwmgkDZcogD2cSUmImSUxSZtmtLzMWxP+CIN8yFJ8gGObZcqC0E0wZGmDVm
	JY2cZ70zG5QlJEwdUz1VG12RzIGIkGgxyHZO4whXn0iXJeiXseZDGVqHUb8JzTIt
	nE308Q4k7gmUaNdRx7K2eckomj+wZ4BqtVVUUrFQgmgXuT4NPf73VeA1N1kMa3KM
	eYkogJ3t88HqBIkh9pyL71bgr1FQpp/egV4wFpOi13sCPNb+DjCys//+XEug4btf
	xvHwWfJDyLAcPY5WDZMKU2AqateOFeuGVejYeRao4Y0L/TXdQcG1fr5hek1wj+oD
	1HEBd191WQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012038.outbound.protection.outlook.com [40.93.1.38])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 44gf8cu2kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 03:59:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a761ID6tfwn14G2n/k1n0znSpbgowOtj91GxWPn75rAHUuxJs5NVmkUcbSsSFhkg3C+ogPzN4H+mPATPywkF6H+mvLZMaWT7NqvmtzsYjjdSjd+hfY2CVZOR4YUl218IQD+We2IiukGzGmiAItbiBxvOoHVRWtnYdu5ePKN4VpWiXXsYA/TMdy4ekZYDlrLu2j4Fc3SbdXh9Yzd111sUymnTpl8QpSP/CNX9RqgvjdmraIt5/qscaVNAKk3J+9zYELTidl3o6BSkG6DuYp/Fa6CH+6XKNFBfT703POK7JfkdhU80EiE52dPmIEtNI9CFPhQCGytR6iWwKQ6MC+AbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Fe2qYBXwLDQ275Cq7peL0lmEfWYUB89oar8hKOO85A=;
 b=qZjUVyTZ1vzoutflytLxIVBePav6CgjnebbCxr1cuyGtYF1kTeu3USt3a/I96B6V9J9H5P0MnGGMl+PGjOFZpHWz7L7908UFQ07kFWN/QdkjCpYfhQk3UNAoSQQNgQtp1TfwP4W9XWlqNIbfg0AY6ZP3fHSNwYTA3t1UeM+IBnng4mwWQ/k+4FRvRP50P2Jqp8K3qe9raV6lHhSHfwsfMTh7dqW/nfKQOLtkdfre6i3vX93p2RhIFhptsO8noG0cDuFWnIJ0m7jyhMMp48+bBGDKqlrsR5AxPEUCixe82gNEwrNWh2R51oPTRc/E6byLVNQWAc6hZPlsn/K8uJ6DpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Fe2qYBXwLDQ275Cq7peL0lmEfWYUB89oar8hKOO85A=;
 b=PS/Xe8cXs9GPR9bRQeYOEqm02I2SjSV0AkDpRmi3DYMTjKkuRLhjyHl/lsoTnjN0YLSVztu7Pm2RBoFdxcSydrVABCMZCrC63Uvsrkb/JLqVmuyazQXtzvTs0wJE5tz0ph8Imk2OK5gFdoq9Z0xq0VDaXn5aeAluDjwGEw3vmpk=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by DS7PR07MB7720.namprd07.prod.outlook.com
 (2603:10b6:5:2c4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 11:59:15 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c%5]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 11:59:14 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com"
	<kw@linux.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Enhance PCIe cadence controller driver for supporting HPA
 architecture
Thread-Topic: [PATCH] Enhance PCIe cadence controller driver for supporting
 HPA architecture
Thread-Index: AQHbchyTfzOJ2HQLaUWpj/zJNr9TybMtVqmQgACJaoCAAsQCYA==
Date: Fri, 31 Jan 2025 11:59:14 +0000
Message-ID:
 <CH2PPF4D26F8E1C337F4C445B609FC07C85A2E82@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CB68755477DCA7AA9C6EBA2EE2@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250129152621.GA460594@bhelgaas>
In-Reply-To: <20250129152621.GA460594@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1jODg5NjhjNi1kZmNhLTExZWYtYTM2?=
 =?us-ascii?Q?OC1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcYzg4OTY4YzgtZGZjYS0xMWVmLWEz?=
 =?us-ascii?Q?NjgtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIxMzkyNiIgdD0iMTMzODI3?=
 =?us-ascii?Q?OTgzNTIyNzY3NTk1IiBoPSJSQ3BxZ1p2OE92bTB4d1U1OFpLYUJIbHd6aG89?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFHQUlBQURyb3VHSzEzUGJBU2l1YmdlemFxMDVLSzV1QjdOcXJUa0tBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBc0JnQUFuQVlBQU1RQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQWhGVjh5UUFBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmpBR0VBWkFCbEFHNEFZd0JsQUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhR?=
 =?us-ascii?Q?QWFRQmhBR3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQVpBQnVBRjhBZGdC?=
 =?us-ascii?Q?b0FHUUFiQUJmQUdzQVpRQjVBSGNBYndCeUFHUUFjd0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFZd0J2QUc0QWRBQmxBRzRBZEFCZkFHMEFZUUIw?=
 =?us-ascii?Q?QUdNQWFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFGQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRB?=
 =?us-ascii?Q?QUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZUUJ6QUcwQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFB?=
 =?us-ascii?Q?QW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFIQUFjQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRWdB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3QnZBSFVB?=
 =?us-ascii?Q?Y2dCakFHVUFZd0J2QUdRQVpRQmZBR01BY3dBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBQUFBQUFC?=
 =?us-ascii?Q?QUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFa?=
 =?us-ascii?Q?QUJsQUY4QVpnQnZBSElBZEFCeUFHRUFiZ0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFB?=
 =?us-ascii?Q?QUFBbmdBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JxQUdFQWRn?=
 =?us-ascii?Q?QmhBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdkFI?=
 =?us-ascii?Q?VUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFIQUFlUUIwQUdnQWJ3QnVBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?RzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBY2dCMUFHSUFlUUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUF4QUVBQUFBQUFBQUlBQUFBQUFBQUFB?=
 =?us-ascii?Q?Z0FBQUFBQUFBQUNBQUFBQUFBQUFDa0FRQUFDZ0FBQURJQUFBQUFBQUFBWXdC?=
 =?us-ascii?Q?aEFHUUFaUUJ1QUdNQVpRQmZBR01BYndCdUFHWUFhUUJrQUdVQWJnQjBBR2tB?=
 =?us-ascii?Q?WVFCc0FBQUFMQUFBQUFBQUFBQmpBR1FBYmdCZkFIWUFhQUJrQUd3QVh3QnJB?=
 =?us-ascii?Q?R1VBZVFCM0FHOEFjZ0JrQUhNQUFBQWtBQUFBQlFBQUFHTUFid0J1QUhRQVpR?=
 =?us-ascii?Q?QnVBSFFBWHdCdEFHRUFkQUJqQUdnQUFBQW1BQUFBQUFBQUFITUFid0IxQUhJ?=
 =?us-ascii?Q?QVl3QmxBR01BYndCa0FHVUFYd0JoQUhNQWJRQUFBQ1lBQUFBU0FBQUFjd0J2?=
 =?us-ascii?Q?QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUdNQWNBQndBQUFBSkFBQUFBRUFB?=
 =?us-ascii?Q?QUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVl3QnpBQUFBTGdBQUFB?=
 =?us-ascii?Q?QUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVpnQnZBSElBZEFC?=
 =?us-ascii?Q?eUFHRUFiZ0FBQUNnQUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FB?=
 =?us-ascii?Q?WlFCZkFHb0FZUUIyQUdFQUFBQXNBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxB?=
 =?us-ascii?Q?R01BYndCa0FHVUFYd0J3QUhrQWRBQm9BRzhBYmdBQUFDZ0FBQUFBQUFBQWN3?=
 =?us-ascii?Q?QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSElBZFFCaUFIa0FBQUE9Ii8+?=
 =?us-ascii?Q?PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|DS7PR07MB7720:EE_
x-ms-office365-filtering-correlation-id: 7c33f677-06df-4bbc-a1fd-08dd41eeaeed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vPsI96qkfA02HHLKwnx6IQ1CqpDa17w6vCG+Jmp1YPM8nh4pfWLxfRDxsRJ9?=
 =?us-ascii?Q?YXv1/kQwC02gAHvmxKEvtEUp1Z85aMnf0WCSOS/IdX6p35cBaQldKd4jHqjV?=
 =?us-ascii?Q?fDLPtnb1YmcepfV4x/0DmpfMQDFUpRm88RSWLy/BIDT0edYpd8EHabNFSMJE?=
 =?us-ascii?Q?k07nfCTzpwxLWOsklAgkgIAIfidC3juZ33nzUvQrBFtjYOo8FS3w2C68SSOs?=
 =?us-ascii?Q?vxEdEnhowLsJ6upMnB8YzSd6l1eRYxKmLJhdIpKVWb/niHt+tTuxWFCv7oJw?=
 =?us-ascii?Q?ZbST7qmUhO7FkGw9G5hAy86WRl9cEm93FygPIa+1ZWvZ4/K+TR/Y2ezGp8+N?=
 =?us-ascii?Q?D1H2goR/GazI008B0V0U/SIm0ukesdZa6N75iB/ZV2gz6UW8Uj3UR4cWUgcK?=
 =?us-ascii?Q?uezGslReHfYLTakyF3SDkBjvfcFGo6cKWUDTu75BcnJQ8cuDirIPqNEErPvG?=
 =?us-ascii?Q?HoU6AwRPV/04pH2CfqKXKcxcA3mlUAV4srBjshe6b6eu+XzZJtvwwvdmHwrE?=
 =?us-ascii?Q?l9AdlddDdCtmjUlOxw4Go2V2YPi3K8nb55RT9Z+uiLe8wv1RBzxA/LPmvsuw?=
 =?us-ascii?Q?U9/ahLUhTw2k9b5Nmwa/SRPe6/9M/ut5/IDy62l/YdW43bExy3AvXCkZR3da?=
 =?us-ascii?Q?7YtGFNmNMr51GGfT8HSGXpLcFx/pIdpGpBTEekHzQ45rMh+cLtjJhIYYPkZC?=
 =?us-ascii?Q?hYU537H6myg3Ddv4Zuj0U3+qJEEqvsEwBlQMkTaXCify+2Gyoo9pliygu12i?=
 =?us-ascii?Q?vdpIdeM/ky74uWTwXso/ng4ShjHbjT4efc9F8GZkovUS2BcUk5x18qQ9xIvc?=
 =?us-ascii?Q?TLbhXTdK0mz8rQu18ErEwWB2CbpwzPukBiP4iJBbGLcamZsu5S3CnvDTjo0b?=
 =?us-ascii?Q?uV/c1wOTfndc71tSVySxe42DnXVGRsG8esnQFsCPFSb22G71UQb5397Jf75z?=
 =?us-ascii?Q?h7AVcu/nmrutiP9tEEjAkjOi+7iN4UiUna9IVqzrowu8kHSCwAo9gAM2SVOe?=
 =?us-ascii?Q?P/PmwrZ1bXLUwHSS3onrpBH5/HjLJ3Ay+4zSU7ACt+USgR7+q5q289f/PKfy?=
 =?us-ascii?Q?+dmb3VBYos/w5RHLwHwtM0N9g9kMscYoQ/K2us3uBl++ApqE1Jzl2JhP8jHV?=
 =?us-ascii?Q?9HhnwBQORWWWTE9U6kuL+3AW1eOv3l3ul1qh6m4b4yL2nHlCmRn2reT2sZBV?=
 =?us-ascii?Q?0QjzktfpqlA7NpnyYF6lDDoJTVV1m+ODWOQgZYURtshD/jdykwHs1DigCTT3?=
 =?us-ascii?Q?H9JDag4ZZ8d2813FxOHvw8pSza81M4J98ASXTz7ufqSzgEjxFYTdJsR3Vs5f?=
 =?us-ascii?Q?TcNLwLFop3lWZ01rr1O6M9bx4cUtxuGSzX3+nELqPd/4jOvo3dOVJfDnB6Yf?=
 =?us-ascii?Q?dNPNX8doE/9WkH+Q0DB5YNd+USEJtMmhT9nfzLOg5hivjCTjUm7qOYEtzW6Y?=
 =?us-ascii?Q?+N5z9w9dIlGJohjBpVtgWBmJcOcitxJh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2ju0Ye0+rqw1wVAQPWhpIjDc8ew9aAvBeq04SL/nUYKJUBrYAQ6KiatzaI3v?=
 =?us-ascii?Q?8hFTrVH+gTft2ArT1TzcuiiszKoUUUC5GXe0OV3+6o0QC9S3xlcp6uUqTLmx?=
 =?us-ascii?Q?8hZMYbetbEpH+/YNT4QTfLOIwAYm/LKVJ3XvWE1Na0ZV7ieYOwZvszES5mub?=
 =?us-ascii?Q?IPgvR/wV6TI2+NqF279Ift5p6OrKS/RCPWipIqeemILo29Xy4ORGAeladdix?=
 =?us-ascii?Q?kFht3O/VcvqYjJH3/7Jhd1QyvrIOgnk+qt5vHyvhIJjcmjqCtXIGYqG+/2iy?=
 =?us-ascii?Q?gkBT9M5cad1eTNcuJk+QEQgyoB8uNT2XTcLzCqp/IJgHgGfHzSKZaymwxsTu?=
 =?us-ascii?Q?a1mG7We+64ptse9Fe+9lKxTKbIRrFkKQtGZI1D1tFcshp2DDeLrYrnXXhhTX?=
 =?us-ascii?Q?oqaOqpWiSG5VZh8I7FdJYlB1FryUR7PL6cDp/j+Z1W5ajXGNmRCIpusXfZz/?=
 =?us-ascii?Q?vg9SEyeylK2ijKxdQunzqnYJHRzUKv+urjo1lee2yVZHilxEH81OMLLv4BoE?=
 =?us-ascii?Q?Ytq3D+WiVNLIxUtKt8rK8ru2NL5aQs0X7m+WVvwSwh4qjZvIqN/U0cDX9shY?=
 =?us-ascii?Q?41h7KaKUFvDnfXvda/Nq4lWJqMYMd0sNzcRkaFpk2fmbwYNiHLR23v0STrIS?=
 =?us-ascii?Q?JsPsIQqNNmU2XM53hge1x0o4ZSyVUDVnwDs7p+PxOWWECqB05SF9piMIvRI2?=
 =?us-ascii?Q?yeYi/BT1GumA+cMA+S2RrslhFSJoyWMrAsksVWuGFudxZRMpujvqBxLzkt73?=
 =?us-ascii?Q?u2z5MISGIIyx7sx6+i7QMR1Xy5IrFBnlmIB7L9mUom92gINQVv3uCIaeG9iY?=
 =?us-ascii?Q?W4WmfWoaQzcFvTmcwjzN0sYSj1A9dr/hYD9k3YLv93gnB5wxWJ10jk6AvdMT?=
 =?us-ascii?Q?dbPwPSNcWPAnEs0VzPQd+1Ng/jYxV+9hA3zufQXErRkAnEaVrY2E6YccfQEr?=
 =?us-ascii?Q?GKb6qXvO90XRjKsoVmSVKhPRF8DEMyic3IG+UeaEn5Ogp8QVnmdrwpQeJQsq?=
 =?us-ascii?Q?0oa44j2FH0mG6jEtRsl5Sb9miBkV86Ut3lATVuZ4AF9/pFbj+H+VwWlgtLWB?=
 =?us-ascii?Q?O6OKfi3UNWuXhwiTcJW3mbsfq0e/xzGxZMQOClRx6yN5OcEBLIA3MyHhI24A?=
 =?us-ascii?Q?95xIet0jXaEPB+12SRJ3+bgpzn+cAFNPV60PnO1Q/YDdrVoFFQ6HsSpm4may?=
 =?us-ascii?Q?1joT0P9KZhRdFnwWMbizWZzLbw71AZQWuaowI1eyDjNB4TNwWbKEQbTpI8DK?=
 =?us-ascii?Q?LYgNQC3DFaMGtHX9ShdiqWqrsrVw+amHhGcVwyohHYiCDOz+ealK/ZZHhOFZ?=
 =?us-ascii?Q?xAFFIXQyyomVQXNA/f9PZYCJtpA/6Wz8XSgv+VTXfre/UHmQjc2hRsi4CFCP?=
 =?us-ascii?Q?HfKiLBCJDcx3Ahmiu2QPt14moizd7O3ffu1cHHUJoYtFSutN3lJFiHPHy2lX?=
 =?us-ascii?Q?I3DsGfzN7agWGBs4jVfF1UF39XgFOEZQiTum1Y9Ea8oxvWAd9N+/TGKHXveT?=
 =?us-ascii?Q?hbnM/T8KmUZFx6UE6SaGyVQe0aLJ03e8TKmQA4TSggQx8St0ni0NX3oV4lti?=
 =?us-ascii?Q?a2CwxaFCS5G8FumRgpZYIQh/n7xN0u7LIwQeao6O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c33f677-06df-4bbc-a1fd-08dd41eeaeed
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 11:59:14.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xXyrMdlnW/KJRFU/X0nPTXnP2HTpkDIWO5gQUHerv/OoKl2cu6qu2WKXlOjaTlePns30X3eyj78JNy8ZYw9BF+KLwcvi0HD+3eBlTtWg0Nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7720
X-Proofpoint-GUID: pnX0_UX7PDR8QNtjl1ZRNIABwEjMjgtS
X-Proofpoint-ORIG-GUID: pnX0_UX7PDR8QNtjl1ZRNIABwEjMjgtS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2501310091


>[PATCH] Enhance PCIe cadence controller driver for supporting
>HPA architecture
>
>EXTERNAL MAIL
>
>
>Take a look at the additions of previous drivers and follow the style.
>For example:
>
>  2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller
>driver")
>  0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller
>driver")
>  da36024a4e83 ("PCI: visconti: Add Toshiba Visconti PCIe host controller
>driver")
>  f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
>
>After skimming the patch, it looks like this doesn't actually add a new dr=
iver,
>but adds support to an existing driver for some kind of different surround=
ing
>platform architecture.
>

The patch adds support for Cadence second generation PCIe controllers, refe=
rred=20
as High performance Architecture(HPA).

>On Wed, Jan 29, 2025 at 07:24:04AM +0000, Manikandan Karunakaran Pillai
>wrote:
>> This patch enhances the Cadence PCIe controller driver to support HPA
>> architecture. The Kconfig is added for PCIE_CADENCE_HPA config, which
>> needs to be selected when HPA compatible PCIe controller is supported.
>> The support for Legacy PCIe controller does not change.
>
>Use imperative mood ("Enhance" instead of "This patch enhances ...").
>
>Expand "HPA".
>
>>  drivers/pci/controller/cadence/Kconfig        |   8 +
>>  .../pci/controller/cadence/pcie-cadence-ep.c  |  12 +-
>>  .../controller/cadence/pcie-cadence-host.c    |  44 ++-
>>  .../pci/controller/cadence/pcie-cadence-hpa.h | 260
>> ++++++++++++++++++  .../controller/cadence/pcie-cadence-legacy.h  |
>> 243 ++++++++++++++++  drivers/pci/controller/cadence/pcie-cadence.c |
>> 42 ++-  drivers/pci/controller/cadence/pcie-cadence.h | 230
>> +---------------
>
>This looks like it should be 5+ separate patches to make this reviewable. =
 Each
>patch should do only *one* thing.  Obviously everything must build and wor=
k
>correctly after each patch is added.
Will break into smaller patches and send them
>
>> +++ b/drivers/pci/controller/cadence/Kconfig
>> @@ -6,6 +6,14 @@ menu "Cadence-based PCIe controllers"
>>  config PCIE_CADENCE
>>  	bool
>>
>> +config PCIE_CADENCE_HPA
>> +	bool "PCIE controller HPA architecture"
>
>s/PCIE/PCIe/ to match other entries.
>
>Change the menu item to match surrounding entries (include vendor,
>host/endpoint, etc).
>
>But I don't think this is a *new* driver; it looks like it might be option=
al
>functionality for the PCIE_CADENCE_PLAT and/or PCI_J721E drivers?  Maybe i=
t
>needs to depend on PCIE_CADENCE?
>
>> +	help
>> +	  Say Y here if you want to support Cadence PCIe Platform controller
>> +	  on HPA architecture
>> +	  The option should be deselected if the Cadence PCIe controller
>> +	  is of legacy architecture
>
>"HPA" must be expanded here too.
>
>Omit the "deselect part".  A user has no way to identify what "legacy
>architecture" means here.
>
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> @@ -121,7 +121,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc=
,
>u8 fn, u8 vfn,
>>  		reg =3D CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
>>  	else
>>  		reg =3D CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
>> +#ifdef CONFIG_PCIE_CADENCE_HPA
>
>Nope.  I don't want #ifdefs like this littered through the cadence generic=
 code.
>The driver should be able to support both HPA and non-HPA in the same
>kernel image.  You should be able to decide at run-time, not at build-time=
.

Cadence PCIe controller does not have a version register that could be used=
 to check the architecture, however=20
one of the PCIe config space registers provides different reset values for =
the different architectures. This register will
be used to support the HPA and non-HPA in the same kernel image.

>
>> +	b =3D (bar < BAR_3) ? bar : bar - BAR_3; #else
>>  	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
>> +#endif
>
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-hpa.h
>> @@ -0,0 +1,260 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */ // Copyright (c) 2017 Cadence
>> +// Cadence PCIe Gen5(HPA) controller driver defines
>
>Space before "(".  Expand HPA.
>
>> + * This file contains the updates/changes for PCIE Gen5 Controller
>
>s/PCIE/PCIe/ everywhere in commit logs and comments.
>
>> +#define CDNS_PCIE_IP_REG_BANK           (0x01000000)
>> +#define CDNS_PCIE_IP_CFG_CTRL_REG_BANK  (0x01003C00) #define
>> +CDNS_PCIE_IP_AXI_MASTER_COMMON  (0x02020000)
>
>No parens needed for bare numbers.
>
>> +/* Vendor ID Register */
>> +#define CDNS_PCIE_LM_ID		        (CDNS_PCIE_IP_REG_BANK +
>0x1420)
>> +#define  CDNS_PCIE_LM_ID_VENDOR_MASK    GENMASK(15, 0)
>> +#define  CDNS_PCIE_LM_ID_VENDOR_SHIFT   0
>
>Omit _SHIFT definitions and use GENMASK()/FIELD_PREP()/FIELD_GET()
>instead.
>
>But it looks like this is mainly a move from one file to another.  A move =
like that
>should be strictly a move and shouldn't change the content at the same tim=
e.
>
>The move should be in its own patch that does nothing other than the move,
>so you can ignore some of these comments for now.
>
>> +#define CDNS_PCIE_LM_EP_FUNC_CFG	(CDNS_PCIE_IP_REG_BANK +
>0x02c0)
>
>Pick either upper-case or lower-case for hex numbers and stick to it.
>
>> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_ENABLE BIT(0) #define
>> +CDNS_PCIE_LM_RC_BAR_CFG_BAR0_IO BIT(1) #define
>> +CDNS_PCIE_LM_RC_BAR_CFG_BAR0_MEM (0) #define
>> +CDNS_PCIE_LM_RC_BAR_CFG_BAR0_32BITS (0) #define
>> +CDNS_PCIE_LM_RC_BAR_CFG_BAR0_PREFETCH_MEM_DISABLE (0)
>
>These are unused.  Don't add #defines that are not used.
>
>When you do add them, indent the BIT() parts to they line up.
>
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
>> ...
>>  	/*
>>  	 * Whatever Bit [23] is set or not inside DESC0 register of the outbou=
nd
>>  	 * PCIe descriptor, the PCI function number must be set into
>>  	 * Bits [26:24] of DESC0 anyway.
>> +	 * for HPA, Bit [26] is set or not inside CTRL0 register of the outbou=
nd
>> +	 * PCI descriptor, the PCI function num must be set into Bits [31:24]
>> +	 * of DESC1 anyway.
>
>Start sentences with a capital letter.
>
>Add blank lines between paragraphs.
>
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -10,213 +10,11 @@
>>  #include <linux/pci.h>
>>  #include <linux/pci-epf.h>
>>  #include <linux/phy/phy.h>
>> -
>> -/* Parameters for the waiting for link up routine */
>> -#define LINK_WAIT_MAX_RETRIES	10
>> -#define LINK_WAIT_USLEEP_MIN	90000
>> -#define LINK_WAIT_USLEEP_MAX	100000
>
>This looks like a move of a lot of things out of pcie-cadence.h to somewhe=
re
>else.  A move like this should be its own patch with its own commit log.
>
>It looks suspect because this is a generic header used by several drivers.
>
>Bjorn

