Return-Path: <linux-pci+bounces-41308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47959C60AC0
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 21:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C32BD4E17BF
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 20:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF22A3093DE;
	Sat, 15 Nov 2025 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="GxvVoKeu"
X-Original-To: linux-pci@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A723EA95;
	Sat, 15 Nov 2025 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763238456; cv=fail; b=Ik2MxM2hr3knHAKThLFiGSFFkKRTFz1K3kTHiz6HI2unNDfpQLbATqsX+2HQXkn46Q8kls567QpztT3YJI8DCATy8xpK9D+kTilYtHJ9Rkm0Sd0udebrJyxw9PBW9p7b9P1SeCT6U/VlH/6bEVLeMBcX3HZM9CjbQguxXQ+KlTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763238456; c=relaxed/simple;
	bh=0oTvO4Q6xXLw3PM9HZGWnEQ9SLM1QA+gVBIlLFZprVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kmwU1n5giC0KoCfLc8tN/B6hME0BJzjMmucyAW5tbxEhoDqYV85xzjwtPZEIZbV9MKoiLKKZyZv3c1ypADE3SGQkRBFUVYV+oNNLVvqrVK/tmlmbF9+wsV/XTBn3zgInBBFy7WYDQhNNWL7jJJGzoYCwy/Ard2vnTQn8MQe1o+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=GxvVoKeu; arc=fail smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2460; q=dns/txt;
  s=iport01; t=1763238455; x=1764448055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MFw/Z1Sf8SjzDqIL5mUOFLjLDVfmbv7DCp/A06Y2PGI=;
  b=GxvVoKeu8Jby3aLxQW8UECWhxZw9UYRbdKDZfK74LjZawVDhj5uUxgTB
   TlIGLVBspSiPqfj+yAJLX/rSKr6ehaYEEQ/FZhp0waRkjbOYH21coqYzq
   WUujx3EJ2YHGDCxLUStgyg5qXZLsveZ64rUXwFEpU0KQwvNvt9pKjBXfk
   e01ts9DWw9AbRGP/RoW4b0LQsqFmr9JQz5hWK8QhyeyWOOQ48gLwLk9vh
   hKj4wkrUnc6VbLyo7XcP/4VmSEVbKHJ4UATXMbnE3p3Jn1clp1bCJxR52
   UTGlD5EhS0Ifgpoo0chdZgqr9E05WZEZfWqHzgS2h6s38CY+krisQeoN8
   Q==;
X-CSE-ConnectionGUID: sD2rEqQ1Sp+cZthrJHjh4Q==
X-CSE-MsgGUID: rP3jq5c+SsyRIpW5K7KUBw==
X-IPAS-Result: =?us-ascii?q?A0AuAAB44Rhp/4wQJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEXBwEBCwGBbVIHghtJiCADhE1fhliCIQOeGoF/DwEBAQ0CUQQBAYUHAoxaA?=
 =?us-ascii?q?iY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchloBA?=
 =?us-ascii?q?QEBAxIVUhACAQgOCi4xJQIEAQ0FCBqFVAMBAqI0AYFAAooreIEBM4EB4CaBS?=
 =?us-ascii?q?gGIUgGFbjuEPScbgg2BV4IwOD6ERYQTgi8EgiKBDoYnjEyGcVJ4HANZLAFVE?=
 =?us-ascii?q?xcLBwWBIBAzAyAKNC0CFA0QEg8EFgUtHXAMKBIQHxgTYFRAg0kQDAZoDwaBE?=
 =?us-ascii?q?hlJAgICBQIrFTqBaAUBHAYcEgIDAQICOlUNgXcCAgSCHH6BbxsPiTWBCQUoA?=
 =?us-ascii?q?wttPTcGDhsFBIE1BZQeUYIsAYEPgS4OUzCWegGwHwqEHKINF6prmQYiqHQCB?=
 =?us-ascii?q?AIEBQIQAQEGgWg8gVlwFYMiUhkPji0WkxsBtU54AjoCBwsBAQMJk2cBAQ?=
IronPort-PHdr: A9a23:7JImNBcSk0XiaewH5fh0ROHIlGM/gIqcDmcuAtIPkblCdOGk55v9e
 RCZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NCBo
IronPort-Data: A9a23:CwKP1q2tXzjBte847PbD5bhxkn2cJEfYwER7XKvMYLTBsI5bpzxTm
 jYeWT2BP/2JMDD1Ltx1bIS1oUgOuJbVnN9qGgM93Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmH4E/xbtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU6
 Lsen+WFYAX4gmctbzpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGF21sJ6ABw79MGSJFx
 +AYMhItbBDfvrfjqF67YrEEasULJc3vOsYb/3pn1zycVa1gSpHYSKKM7thdtNsyrpkRRrCFO
 YxAN3w2MEyojx5nYj/7DLo9lf20h332cBVTqUmeouw85G27IAlZjuG2aoGOKoDULSlTtlyg/
 WDfom+6OQoLDv2H9memrVGRrPCayEsXX6pXTtVU7MVCi1CLxikfBQMbUXOlrvSjzE2zQdRSL
 woT4CVGhawz8lG7C9DnWli9u3usoBERQZxTHvc85QXLzbDbiy6dB24ZXntNb9cOqsA7X3op2
 0WPktevAiZg2JWRSHSA5vKXoCm0NCw9M2APf2kHQBED7t2lp5s85jrLT9B+AOuwg9H0EBnuz
 D2Q6isznbMeiYgMzarT1VTGhS+8453MRSYr6QjNGGGo9AV0YMiifYPAwVza6+tQaZ6ST3Gfs
 3Ue3cuT9uYDCdeKjiPlaOEMGqy5ou3eYWX0n1FiBd8i+i6r9nrleppfiBl6JUF0IoMfciToS
 FHctBkX55JJOnauK6htbOqZD8Us0LilCc7sXf2RbddUZJV1XBGI8TsoZkOK2W3p1k82nskXP
 5qHfcuyJWgVBL4hzzesQeoZl7gxyUgDKXj7TJT/yVGjlLGZfnPQEexDO1qVZed/56SByOnIz
 +ti2wKx40w3eMX1YzLc9sgYKlViEJTxLcyeRxB/HgJbHjdbJQ==
IronPort-HdrOrdr: A9a23:kTkg4aAIxVdsljHlHejjsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskduZJhBo7y90KnpewK7yXcH2/hhAV7EZniohILIFvAv0WKM+UybJ8STzJ846U
 4kSdkANDSSNyk1sS+Z2njELz9I+rDum87Y55a6854ud3AXV0gK1XYBNu/vKDwMeOAwP+tAKH
 Pz3LshmxOQPV4sQoCQAH4DU+Lfp9vNuq7HTHc9bSIP2U2ltx/tzKT1PSS5834lPg+nx41MzU
 H11yjCoomzufCyzRHRk0XJ6Y5NpdfnwtxfQOSRl8k8MFzX+0aVTbUkf4fHkCE+oemp5lpvus
 LLuQ0cM8N67G6UVn2poCHqxxLr3F8VmjzfIB6j8DneSP7CNXYH4vl69MVkm9zimgwdVeRHoe
 d2NqSixsNq5F377XzADpPzJmFXfwKP0AkfeKgo/j1iuU90Us4KkWTZl3klS6soDWb07psqH/
 JpC9yZ7PFKcUmCZ3ScpWV3xsewN05DVStub3Jy8/B96QIm1ExR3g8d3ogSj30A/JUyR91N4P
 nFKL1hkPVLQtUNZaxwCe8dSY/vY1a9DC7kISaXOxDqBasHM3XCp9r+56g0/vijfNgNwIEpkJ
 rMXVtEvSo5el7oC8eJwJpXmyq9ClmVTHDo0IVT9pJ5srrzSP7iNjCCUkknl4+6r/AWEqTgKo
 CO0VJtcojexEfVaPJ0NlfFKutvwFElIbgohuo=
X-Talos-CUID: 9a23:E45l6WESOm9f5KyLqmJ82BQON9kcK0bFj3ziP0+iK0ZrSOGsHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A7cgdEAxQyAai52VsbiV+kgGciEeaqL6WU0IUzJ5?=
 =?us-ascii?q?FgNKVDw1oBGq+0xeKaJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-03.cisco.com ([173.36.16.140])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Nov 2025 20:27:25 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-03.cisco.com (Postfix) with ESMTPS id 0F07C18000403;
	Sat, 15 Nov 2025 20:27:25 +0000 (GMT)
X-CSE-ConnectionGUID: 9IGLtmi+SbWDArDZBSRfYQ==
X-CSE-MsgGUID: OwvumJ/eRDCics6ueVBrMQ==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.19,307,1754956800"; 
   d="scan'208";a="61701058"
Received: from mail-dm5pr08cu00407.outbound.protection.outlook.com (HELO DM5PR08CU004.outbound.protection.outlook.com) ([40.93.13.103])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Nov 2025 20:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/Zfi6W5LuTTMhUxXAydYPEJj3UhQ/r7u8BdXcIgbkAPXVDgR/f0IlAeGZ4ZbthcdIkoDOQyTtXRRMXX+0xQGGTlAn4kVUhcSjtcSsono/lh9PItyxzjlA5c8AvTJ75yG5gdnNyACHBSOkWBUCfQ4xma5G5OnNkAKaYcymBUnYa7hkvOhtt5GbI07swmSEGQF2J+6X4+BMq19WQ3fNOhUkFr5cq34QZSx70pee6VqP8x3MZvi9oGeoFf8eyqxsOSYU2fWL1Ka2ULZESAzihOOLjEb2W7vnJJYHk30FUp3H3Dd0+dd18SMk+IdkU7u1li8QZwnzgQA/orW6dXQNLlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFw/Z1Sf8SjzDqIL5mUOFLjLDVfmbv7DCp/A06Y2PGI=;
 b=ejqVQ290Ii4mWw5iKhsOXD8PBvwwHu8O7BnuT7/J6DKsLxVg0KfJzWz33QUM9JTsFUzE6PDEnzszsnM0pIdnOXc72br0NOy9MsyBDdYZqp46yDbHfUWtnjkw+FQU+s52nWUJhTon5oCWQVGbz+4NcjtTFjOyALWSqdYFY8RkKoavntXken2PlB4pIsNJnjNWVFAYP/l5rpVRD8EpU5o6oGDpOwwfPm4mMmacc9IopIJz2ymCEKxCCVK+/y5pmwaq9DfNUhm8dsb/LwWFvTRCeEzeoxpDdhC87EClZ+DS6dfNnEWkpJc8MqBbvJ3/RiqstVlUC5FCdNlNiJMSKyloCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by DS4PPFE70B31BEF.namprd11.prod.outlook.com (2603:10b6:f:fc02::5a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Sat, 15 Nov
 2025 20:27:20 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd%4]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 20:27:19 +0000
From: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Corey Minyard
	<corey@minyard.net>, =?iso-8859-2?Q?Christian_K=F6nig?=
	<christian.koenig@amd.com>, "Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>, Thomas Zimmermann
	<tzimmermann@suse.de>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>, Matthew Brost
	<matthew.brost@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, Vitaly Lifshits
	<vitaly.lifshits@intel.com>, Manivannan Sadhasivam <mani@kernel.org>, Niklas
 Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Sagi Maimon <maimon.sagi@gmail.com>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, Hans Verkuil
	<hverkuil+cisco@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, Steven
 Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, Viacheslav
 Dubeyko <Slava.Dubeyko@ibm.com>, Max Kellermann <max.kellermann@ionos.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org"
	<linaro-mm-sig@lists.linaro.org>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "freedreno@lists.freedesktop.org"
	<freedreno@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>, "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Sumit Semwal
	<sumit.semwal@linaro.org>, Gustavo Padovan <gustavo@padovan.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
	<abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul
	<sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>,
	=?iso-8859-2?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Narsimhulu
 Musini (nmusini)" <nmusini@cisco.com>, Paolo Abeni <pabeni@redhat.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Rodolfo Giometti <giometti@enneenne.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Stefan Haberland <sth@linux.ibm.com>, Jan
 Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, "Satish Kharat (satishkh)" <satishkh@cisco.com>,
	"Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xiubo
 Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>, "Gian Carlo Boffa (gcboffa)"
	<gcboffa@cisco.com>, "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>
Subject: RE: [PATCH v3 20/21] scsi: snic: Switch to use %ptSp
Thread-Topic: [PATCH v3 20/21] scsi: snic: Switch to use %ptSp
Thread-Index: AQHcVK6i2TuKalB1aEOcW1L+o6TUn7T0MoDA
Date: Sat, 15 Nov 2025 20:27:19 +0000
Message-ID:
 <SJ0PR11MB58960101609D15FB8F6FB5B2C3CBA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-21-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251113150217.3030010-21-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|DS4PPFE70B31BEF:EE_
x-ms-office365-filtering-correlation-id: 06dc7afe-7be7-41d7-220d-08de24856052
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?UTyLHl4BJYTK4mtPS91Sw2Srl0NHvlfMZaTqLxu2rUWxwfXqFudlc+5TWZ?=
 =?iso-8859-2?Q?BJrEBNZocoITs1OavCRqzXqvbXtC3nyiTs+X6BNCP++7KlQ2g2MJnYpALp?=
 =?iso-8859-2?Q?Bn5YPtijrc89YM4uqb1zvNiGQUKCmcJm5aV9n2jDlaisDBGoiOEdehli0Z?=
 =?iso-8859-2?Q?AiBZgIYvmeuLyJ94TRvdhfcWNgAInVk2bzv3iJn+ETi2yjnYFqeJDEsP/c?=
 =?iso-8859-2?Q?52tSR8uLyZ/cTHCDYdEy2M4TMyDvk7xp0fRxtDf6gySeGMeb9hFUl3m94o?=
 =?iso-8859-2?Q?9QGxesrQwqKEd/FjIbfevU9AIIu/4425oQt60PEDl2KHxaaeh+AA/kE+If?=
 =?iso-8859-2?Q?cTIhv+ekBi5Kio8han64MSlNeDN+sR6xKhQ/jxgIlLI9yNDFUyww8nWAm5?=
 =?iso-8859-2?Q?SxG/facdPQxoPEpca86hn/+obDhPgWbR/ztj7tbF7ANig0cXm/9lKdnZoZ?=
 =?iso-8859-2?Q?e2S/yQsrsL8JID1eQiuiQr7psiOVeOBrtmr5hP9t6gIIVMZnZvIcwbi1Dc?=
 =?iso-8859-2?Q?pIvEJrA62KfIEsG0lGAYmYo4C0gZHqFgr7DWsaVfEAJWKIQEw+NVLL06fR?=
 =?iso-8859-2?Q?kxKmQM6BCA0FLcSlIScOrAAOBXrkQx8CDVbtdiiK6WgcSEAZeGneow5obu?=
 =?iso-8859-2?Q?DAj3Um0LuFxhd4vwv0VnU/9xHqXWAgIWM8XtzAwyS//bRDdCRnV1M1Ynt3?=
 =?iso-8859-2?Q?a5G+dYsTHrt3OFCJQcrYObQ6i3mZy/rMEXFoSyhPJXNNEdgWxwoB1HncUE?=
 =?iso-8859-2?Q?4rYNimG0/N/xCyPNM8ep24M113OR2BqbeCl3DNYllfbQxGN78FCOYN6ZIE?=
 =?iso-8859-2?Q?phsDl0tQWTOljwdp7051kUzoU0wbE9PpBzs61KFHlB25iEfK2WgEBoV82H?=
 =?iso-8859-2?Q?C3yaXZ0BCTPUNLjRuQmgvzHU5ng4f8VDQtXXPfR+oYzmwJKohYU9q+EL+t?=
 =?iso-8859-2?Q?p41Xg0+NxjykvmlvZM0im3m1zsEQ6O7xp9jzLSW3CSy7Ug4BD8U/f3loX6?=
 =?iso-8859-2?Q?m2dgZ7IV42D8gpPaSgZGxQfxdjuNZF06eztZWNwwtTbG2xJCCy5kJDjABj?=
 =?iso-8859-2?Q?kprDaZzeCplxAQW8xfkkmstWs5hIltTmdYlLszIG41MjqxWZJZpClawbb1?=
 =?iso-8859-2?Q?XipTfYbbjUUTJ5AY/cJ94Ocn6B1jSeJph/3BbItNRMvxRi6ONwCwbBDbP+?=
 =?iso-8859-2?Q?Le6I4IDVHcH5ofHexkpBJuMrroWBuSTjhDDNC3TqJdl72rmfZgLyVoS77N?=
 =?iso-8859-2?Q?yU/NIXbFlb8l9dK8q5jipLd1/FVk4Pp2P60jy+9m9cVnFbtvQjhXDypzeb?=
 =?iso-8859-2?Q?Ko1fH/QTTvV8pcNWJXq7fLf1O2d3JWe1yLLsUfK2TmQq0D5l5DpbB890yC?=
 =?iso-8859-2?Q?BVF/Ar5qTiLG7xggV8j4UXRb++gCvrDvk/yLsnEeOoqoE6pmrgwYAC6qZd?=
 =?iso-8859-2?Q?7sl4WiSn6wVEF9onXMgQmhjZwpqInrPFVmYPD5v5xlZBo9t8R0x2wBdi0r?=
 =?iso-8859-2?Q?1cJFwkDZ8sMDxKKKjLHjDI1tR9ldHAmzEmiKNR0GMuTz2ixBFx6wGgLXzl?=
 =?iso-8859-2?Q?wRoYHekrIzXtWBvjBDW4wBo0MryqgrcAtLVl4aPMAV4isfK9tw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?mKPbxCR50Zo/kBjFEIBIzbg6Es+ioxMMbEP7y4nJHK5XxBuKmBIhsyNe+c?=
 =?iso-8859-2?Q?P2PSImE1GXaPLwYEl2o0/N61ZqojPjfvrKsOv95iPU39dTSM2smMfyKa+b?=
 =?iso-8859-2?Q?yJ4MGTfyQcIrBV8ERN3vhUzyykJsgm9hEjRp0sYKTEOshqL4DV0ZfF0XIg?=
 =?iso-8859-2?Q?gSDYhrSwytejuBS2OhEKMlIRkHHQ7vytYCaFWfly2CZuaC6WJXN+qiqsDq?=
 =?iso-8859-2?Q?1wx+Flmo+eU+kxwC2S6ohnAeGzoxOeATpzP8czrMmvNgNv2SUtLjE6cpa6?=
 =?iso-8859-2?Q?CclM+6tyecZ4BTj7JPQNb+6McoBOVK2q7+LBl8VLvNUQ7Auam18+LneqCQ?=
 =?iso-8859-2?Q?OdOlDAEMcBPZg8du9cjYXV5ziDfXS8eYRmiGGpRe07zxj+E8FoJ6/CTVMd?=
 =?iso-8859-2?Q?7Kgi/HmvzryfBpo19AiuIOsdQYexfBhlJrLeDouh2L4yI08/Bbbl/kF8S5?=
 =?iso-8859-2?Q?+h6QuqJAMGwbkVFi3H1iqPsWXwLhY+gBMTbRuAnRl3CW/Yqzn1g39aa01o?=
 =?iso-8859-2?Q?cSQBDMI/SLuz65WdsanquiGJtbc/0CizuwL73kKQEb3Npn7di05o36xFWv?=
 =?iso-8859-2?Q?DEHcIldFhQXWwU2/gi5S2mXbMZmMCcyxEChQZkp0IE5lY0kODGyWfdDf2y?=
 =?iso-8859-2?Q?bETAGONsgtujjymUy1NAzor3kNZfB5tXwvpdVhrcAXo6LgPM0rFNGD6A58?=
 =?iso-8859-2?Q?6e/TskoSTgrkkg2uQDl2fzAYuGSIWLRUOariSlHuDDWemN2wBqBA0MUTPl?=
 =?iso-8859-2?Q?hgWCGKJIeDmhFv0/Y6bb+DT1H8rfdgxFfpEsh0+GSrBLTQhdDNi1t12f6f?=
 =?iso-8859-2?Q?XvROYBBSf7yzbEeHNW061lBKryfZqrvEHoMQuxPZKog/eOcdils30zwWnx?=
 =?iso-8859-2?Q?b/g6Qe2gspFfKmOdFOxepWKUsWsbnn8706go1E0uxXQTSvmXBcWwXBiYOd?=
 =?iso-8859-2?Q?XQcuKAqoZHHqw9Fb33/Qls/MseykH+NwDBNjX8o7TzR42pQKLf0HRYYGmb?=
 =?iso-8859-2?Q?0TLbowvsUzqn8Lnw42QWD5zzs9U80/mBCiHgHGcw1sFZXpgtC7b35d9BMt?=
 =?iso-8859-2?Q?zmA+oMzsghS3CdaIpJDV6n6mkI4QAlzbJ3RtlkXKbZ9eyBsA+YLQxaQq7p?=
 =?iso-8859-2?Q?HlVl87dlyRvwiXVa6gN4AxQQFclSPqONjcJ0ONO8DnDed4HSKwTNi5Ck1a?=
 =?iso-8859-2?Q?L2SYeW3kbJ41H7lF8WtreIUTJlevxAXf9H3833F5uA/caq+ev/Kf0FdDGK?=
 =?iso-8859-2?Q?yzS1iLutsB5PRhD1boh2gNU8RNC+6uPW1HLm0zHdUv6O4FqR3bbk/cLXOO?=
 =?iso-8859-2?Q?11lyG2zvkvia2pfWVROOpk8PgmvBHIHfCsIaDBWk9vXHFIgB+XyRPiaTTS?=
 =?iso-8859-2?Q?bsGblhc1scXXBJm6wDK24/nRbjFauqXawoxqAO16Jnavr6awCe+E0I5Ryf?=
 =?iso-8859-2?Q?nqUSFrJWfmemtxmMsGaUrdB9yWH/b6Zh2b4cYt5w+ekjkzVh5jn9WBJH9E?=
 =?iso-8859-2?Q?Dk9asRPl15WV6Ci7yTnuTI0CQdvVNtek4nLjE5XF2Jr3UX0Z/+U8K7i8QQ?=
 =?iso-8859-2?Q?yimx4UwBS+uDjiCMwzI1l50RwO5DpDjuoKLQabZf9rzmCxWZaarV19F+IU?=
 =?iso-8859-2?Q?RR+FiRm8NFYq8q/t4x9gOYsXV9u/TNMndx?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dc7afe-7be7-41d7-220d-08de24856052
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2025 20:27:19.8090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6sGSzNOwK5N2JX7LP+uBMy+DCipcCcM2IKRDSemuaKx2VgJ+Cpek7Aeyqj1K9YjSnc1FgC1NdcbLcIoAPUC6Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE70B31BEF
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-03.cisco.com

On Thursday, November 13, 2025 6:33 AM, Andy Shevchenko <andriy.shevchenko@=
linux.intel.com> wrote:
>
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/scsi/snic/snic_debugfs.c | 10 ++++------
> drivers/scsi/snic/snic_trc.c     |  5 ++---
> 2 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_de=
bugfs.c
> index 9dd975b36b5b..edf3e5ef28a6 100644
> --- a/drivers/scsi/snic/snic_debugfs.c
> +++ b/drivers/scsi/snic/snic_debugfs.c
> @@ -282,8 +282,8 @@ snic_stats_show(struct seq_file *sfp, void *data)
> jiffies_to_timespec64(stats->misc.last_ack_time, &last_ack_tms);
>
> seq_printf(sfp,
> -                "Last ISR Time               : %llu (%8llu.%09lu)\n"
> -                "Last Ack Time               : %llu (%8llu.%09lu)\n"
> +                "Last ISR Time               : %llu (%ptSp)\n"
> +                "Last Ack Time               : %llu (%ptSp)\n"
> "Ack ISRs                    : %llu\n"
> "IO Cmpl ISRs                : %llu\n"
> "Err Notify ISRs             : %llu\n"
> @@ -298,10 +298,8 @@ snic_stats_show(struct seq_file *sfp, void *data)
> "Queue Ramp Down             : %lld\n"
> "Queue Last Queue Depth      : %lld\n"
> "Target Not Ready            : %lld\n",
> -                (u64) stats->misc.last_isr_time,
> -                last_isr_tms.tv_sec, last_isr_tms.tv_nsec,
> -                (u64)stats->misc.last_ack_time,
> -                last_ack_tms.tv_sec, last_ack_tms.tv_nsec,
> +                (u64) stats->misc.last_isr_time, &last_isr_tms,
> +                (u64) stats->misc.last_ack_time, &last_ack_tms,
> (u64) atomic64_read(&stats->misc.ack_isr_cnt),
> (u64) atomic64_read(&stats->misc.cmpl_isr_cnt),
> (u64) atomic64_read(&stats->misc.errnotify_isr_cnt),
> diff --git a/drivers/scsi/snic/snic_trc.c b/drivers/scsi/snic/snic_trc.c
> index c2e5ab7e976c..6bad1ea9a6a7 100644
> --- a/drivers/scsi/snic/snic_trc.c
> +++ b/drivers/scsi/snic/snic_trc.c
> @@ -56,9 +56,8 @@ snic_fmt_trc_data(struct snic_trc_data *td, char *buf, =
int buf_sz)
> jiffies_to_timespec64(td->ts, &tmspec);
>
> len +=3D snprintf(buf, buf_sz,
> -                     "%llu.%09lu %-25s %3d %4x %16llx %16llx %16llx %16l=
lx %16llx\n",
> -                     tmspec.tv_sec,
> -                     tmspec.tv_nsec,
> +                     "%ptSp %-25s %3d %4x %16llx %16llx %16llx %16llx %1=
6llx\n",
> +                     &tmspec,
> td->fn,
> td->hno,
> td->tag,
> --
> 2.50.1
>
>

Thanks for the change, Andy.

Acked-by: Karan Tilak Kumar <kartilak@cisco.com>

Regards,
Karan

