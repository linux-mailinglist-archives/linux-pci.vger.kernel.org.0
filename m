Return-Path: <linux-pci+bounces-41194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D728AC5A597
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 23:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B034C4E8B15
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 22:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696A22E62D9;
	Thu, 13 Nov 2025 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="Rv2ofXhP"
X-Original-To: linux-pci@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19432E1C63;
	Thu, 13 Nov 2025 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073356; cv=fail; b=gpkSzXAjuCRDh2tKaJHe8U06w9SipaNVdc43gx7CSwaHoOJ749jXbnGWmUtzud0JOF4jPJNhHegcSu5i/oIpo8Hl71A7daMDaaqjxjDSF/s4CngUQk5J4KO6v+cqq3jIcSB1xbg3w2LtXQ2u2v4LafU9FcTQEvAy3d9gRa0QcBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073356; c=relaxed/simple;
	bh=/LFIz8b/vnOk4xaxu82tLCxZVOvqSWxIrQzi12AREJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PhlQjx3itgFoMs6azyk0HoR2xgCigG9E/O7Ez82AVL/BNxooD6V8JX3yZ7fVTBv4txu1KEOadFBqHvcIh1fj6WpXW6GJdOUKNwB5DnYO64grawSn9ibweU9rVjQoILdPcwMdwsTCQLe2I+wIup7kiQA7bCprHfl0fs3poZqRkKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Rv2ofXhP; arc=fail smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5367; q=dns/txt;
  s=iport01; t=1763073354; x=1764282954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8JVJ68Ci8hH+vA9bF8YiFlkwB1Lv6uIdcNwtst+8pPM=;
  b=Rv2ofXhPV9RN97WVfOoeyGdrIgy7IdOjBIoeEu/ltUs6h2Ga+cT3J1HV
   Yv1de5p5pwCuWUuzNbHvS34w4P2Dip3yo9oxiCIQkReLS2iDmSHW3nPf8
   Dtpl3gIa3ShCn2HVianjr33gpnJLX1+fgExRPVSydX3zXtQAdGqbTpPNp
   cg39wc9xbimquxzYCHMSsNokH1bhC+MWpXvb43qb7fyIK2tngku0RLTpD
   ucHobNinUBP6frOzAidQSXkl7Vqk798HE6GsZR36VtyVFB36aoQgVqNOV
   jruAXzhHttTkAZyGhiFlDf11admcsFYScy/+qw/sRBgyunGEOWekYdGn2
   Q==;
X-CSE-ConnectionGUID: +04yFXkrTtOIXKIUyztPdQ==
X-CSE-MsgGUID: /IUTXCN/RjGGLrAdlPRTIg==
X-IPAS-Result: =?us-ascii?q?A0BAAAByXBZp/5EQJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEYBgEBCwGBbVIHghtJiCADhSyGWIIhA54aFIFrDwEBAQ0CUQQBAYUHAoxaA?=
 =?us-ascii?q?iY1CA4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchloBA?=
 =?us-ascii?q?QEBAxIVUhACAQgOCi4xJQIEAQ0FCBqFVAMBAqRLAYFAAooreIEBM4EB4CaBS?=
 =?us-ascii?q?gGIUgGFbjuEPScbgg2BV3mBbz6EKhuEE4IvBIIigQ6GJ3mLYIZjUngcA1ksA?=
 =?us-ascii?q?VUTFwsHBYEgEDMDIAo0LQIUDRASDwQWBS0dcAwoEhAfGBFgVECDSRAMBmgPB?=
 =?us-ascii?q?oESGUkCAgIFAisVOoFoBQEcBhwSAgMBAgI6VQ2BdwICBIIZfoFvGw+JSIEaA?=
 =?us-ascii?q?wttPTcGDhsFBIE1BZQUghNpAT1RgTEMUwQsY5JsCIMjAbAfCoQcog0XhASNE?=
 =?us-ascii?q?4cCklKZBiKodAIEAgQFAhABAQaBaQE6gVlwFYMiUhkPji0WkxsBtUN4AjoCB?=
 =?us-ascii?q?wsBAQMJk2cBAQ?=
IronPort-PHdr: A9a23:j7lK4hJIypBFWO3lXtmcuVQyDhhOgF28FgcR7pxijKpBbeH4uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1oNwg==
IronPort-Data: A9a23:gE7Qka1YRYGtvW/mYfbD5bhxkn2cJEfYwER7XKvMYLTBsI5bp2EAm
 mIaX2mEa6rYZWXwf9gjYISwoUgHvp6HxtZiHQA/3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmH4E/xbtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU6
 Lsen+WFYAX4gmctaTpPg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGTxlqLKMo+fxLHUZvx
 d85FSEfciiPvrfjqF67YrEEasULJc3vOsYb/3pn1zycVaZgSpHYSKKM7thdtNsyrpkRRrCFO
 YxAN3w2MEmojx5nYj/7DLo9lf20h332cBVTqUmeouw85G27IAlZjuG0bYKEJo3TLSlTtgG5m
 1721EK+OBM1G/iF4DaBykiQp+CayEsXX6pXTtVU7MVCi1CLxikfBQMbUXOlrvSjzE2zQdRSL
 woT4CVGhawz8lG7C9DnWli9u3usoBERQZxTHvc85QXLzbDbiy6dB24ZXntNb9cOqsA7X3op2
 0WPktevAiZg2JWRSHSA5vKXoCm0NCw9M2APf2kHQBED7t2lp5s85jrLT9B+AOuwg9H0EBnuz
 D2Q6isznbMeiYgMzarT1VTGhS+8453MRSYr6QjNGGGo9AV0YMiifYPAwVza6+tQaZ6ST3Gfs
 3Ue3cuT9uYDCdeKjiPlaOEMGqy5ou3eYWX0n1FiBd8i+i6r9nrleppfiBl6JUF0IoMfciToS
 FHctBkX55JJOnauK6htbOqZD8Us0LilCc7sXf2RbddUZJV1XBGI8TsoZkOK2W3p1k82nskXP
 5qHfcuyJWgVBL4hzzesQeoZl7gxyUgDKXj7TJT/yVGjlLGZfnPQEedDO1qVZed/56SByOnIz
 +ti2wKx40w3eMX1YzLc9sgYKlViEJTxLcueRxB/HgJbHjdbJQ==
IronPort-HdrOrdr: A9a23:9WIcX6+bVKvIj4Bhjcpuk+GXdr1zdoMgy1knxilNoENuA6+lfp
 GV/MjziyWUtN9IYgBfpTnhAsW9qXO1z+8S3WBjB8bSYOCAghrmEGgC1/qv/9SOIVyFygcw79
 YFT0E6MqyOMbEYt7e13ODbKadc/DDvysnB7omurQYJcegpUdAd0+4TMHfjLqQCfng8OXNPLu
 vl2iMonUvGRV0nKu6AKj0uWe/Fq9fXlJTgTyInKnccgjWmvHeD0pK/NwKX8Cs/flp0rIvK91
 KrryXJooGY992rwB7V0GHeq75MnsH699dFDMuQzuAINzTFkG+TFcRccozHmApwjPCk6V4snt
 WJiQwnJd5P53TYeXzwiQfx2jPnzC0l5xbZuBylaDrY0I7ErQABeo58bLFiA1zkAo0bzZdBOZ
 dwriekXlxsfEr9dWrGloD1vlpR5zqJSDIZ4J0uZjpkIMojgHs7l/1EwKuTe61wRx7S+cQpFv
 JjA9rb4+sTeVSGb2rBtm0q29C0WG8vdy32CXTql/blmgS+pkoJh3cw1YgahDMN5Zg9Q55L66
 DNNblpjqhHSosTYbhmDOkMTMOrAiiVKCi8fV66MBDiDuUKKnjNo5n47PE84/yrYoUByN83lI
 7aWF1VuGYucwblCNGI3pdM7hfRKV/NFwjF24Vb/dx0q7f8TL3kPWmKT00vidKpp7EFDsjSS5
 +ISeRr6j/YXBzT8KpyrnnDssNpWAsjueUuy6MGZ24=
X-Talos-CUID: =?us-ascii?q?9a23=3AFhUfb2iPb0If+ybfR88GUNh/fTJuMSWB3VngIFW?=
 =?us-ascii?q?EFUFIeJ60dE6C5Jtoqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A4HUZpAx+b1Sk0ZQLTa73jUOR4RWaqOOPNXw9urN?=
 =?us-ascii?q?BgcurGghqEjuZtA6LY4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2025 22:34:45 +0000
Received: from alln-opgw-3.cisco.com (alln-opgw-3.cisco.com [173.37.147.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-08.cisco.com (Postfix) with ESMTPS id 922FB1800075E;
	Thu, 13 Nov 2025 22:34:45 +0000 (GMT)
X-CSE-ConnectionGUID: GCrkPvmrQQyYT0zT2MC+fg==
X-CSE-MsgGUID: XijHqBfrRMaTSrqVw0ziAg==
Authentication-Results: alln-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.19,303,1754956800"; 
   d="scan'208";a="36153306"
Received: from mail-ch4pr07cu00101.outbound.protection.outlook.com (HELO CH4PR07CU001.outbound.protection.outlook.com) ([40.93.20.97])
  by alln-opgw-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2025 22:34:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzxoebjS9ToWZ6hkFn/yQS0iiplaQq1B4uUQr0RFXuTMtZe72qWKPaG3zeMn26vWbIUlrcW0xe1x5Z6AE/AQ0C3bRseVPhIvBh3olnvhwkAvI1F8xuvYDAqZY+ca8QP9WQOpcwDN0FIJjZm7eFuCIJCHeOFchgTOrzE5tGxI318PpwHZH/atRcXt0450+vS7OqWhGblRJM6hGqVaLVHf+Gn0pfH59UDzAzTCqwBFYuynnIPrV8z/D0SF780/FcP5TPFqLGc4Jz7vVUu5owU/wPyl+CqljKGnPurboag5vnjAWCn0pDFc7X1cRjSr929YyrQV+gyZrAx+Dk/ie/Bu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JVJ68Ci8hH+vA9bF8YiFlkwB1Lv6uIdcNwtst+8pPM=;
 b=wQak6JIoINwHL1xP/fq5L8vTabF8f9R4aD+z5MVNdyLO+dN/g9+GwFS4wtQ4KpOUrOV/kRnaI+ktN3ACIpuQul8qUUSJt04bppepZcDS8kp98Ps9pCxaNLxJkNI7pJXih62kvQ2gfhiToK69kKhcJA49IIEDsk4YkNzmRnS7EqBTimK6tiMMDQnRpHB2J7BO0RHFdWfEiwT++GtOp40H2PsMvirkCTQ6e25HPa76rYFIrzzc+kbkUO5v43lrHyZ47I8j8uICIS3yyPyUrko2G3AXGl4YRv5pOeXPVjDK9CtK2HT3DJjv3kY5fNw+MwypfUD15ctnAIHmdjTbfUdP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by IA1PR11MB7755.namprd11.prod.outlook.com (2603:10b6:208:420::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 22:34:36 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 22:34:36 +0000
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
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Kishon
 Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Rodolfo Giometti <giometti@enneenne.com>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "Satish
 Kharat (satishkh)" <satishkh@cisco.com>, "Sesidhar Baddela (sebaddel)"
	<sebaddel@cisco.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xiubo
 Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH v3 19/21] scsi: fnic: Switch to use %ptSp
Thread-Topic: [PATCH v3 19/21] scsi: fnic: Switch to use %ptSp
Thread-Index: AQHcVK6ozanKNwbcFU2LSi/oClNkW7TxMIPg
Date: Thu, 13 Nov 2025 22:34:36 +0000
Message-ID:
 <SJ0PR11MB5896D2F9DAC35FF8ADB29087C3CDA@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-20-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251113150217.3030010-20-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|IA1PR11MB7755:EE_
x-ms-office365-filtering-correlation-id: 3cf75da7-1b8e-4777-1265-08de2304d313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?EV+qDQ4opgT6YErEt+UTHCFYqvHTNJI5xuKV0TWvVDABI0Ef8+VDdGTavR?=
 =?iso-8859-2?Q?SNJR5b3R0U9xD3zMHb8nX29wKP3IboINDE5Vu3YwhbTGwLiATuVYXvnS/z?=
 =?iso-8859-2?Q?IuCxsetISmon5JlHrjND3OG8FJcZK0TctHcd7wsSq0vX5gTK4Mly8e2tXB?=
 =?iso-8859-2?Q?8niGQPhFBtcfIvxSP02U+OsRVhVAlAZU9FNl3umrxpWNh2Ou/gAUtKMMja?=
 =?iso-8859-2?Q?vuk/ZOK8y62KRUh4+Yqy1hLRgoy4MzxIQm9ENoDUDKejiY6VAmxaHBtFMv?=
 =?iso-8859-2?Q?khC+LYVKosq8tq4fM65y1+JzsHqZPyWKtv2KiMvx/00QoNn4AxpcNxgov/?=
 =?iso-8859-2?Q?f7J3E9cKAtg2zReMnMxzzrtN3tDrlmZvQPQGDFohM7peloBOxRkKX2glgv?=
 =?iso-8859-2?Q?6p593bO9o3W6G9PSesKeQ9Qk4a9MIRTejqyErN++fwt7BiOL2Oda2guwYK?=
 =?iso-8859-2?Q?DzzccPSUzCrJOelr77JA9iEVIu8KJnD2fd66UlCv7gk3Fh/B5QZXLJaGtu?=
 =?iso-8859-2?Q?5LG5k8+7w3IoPhyFfMFqo25jCT+TxxiBwFSXTUJEPDjp9yLPR/o545NFJ7?=
 =?iso-8859-2?Q?dqplbeu5arprxhwRAyU085ei3Qb9ABYMk0kBR5G3nrwItNBjoNKE7rLfZ2?=
 =?iso-8859-2?Q?WL5jfsO+dsZjt6gxuOMRbyO47AgSAm5bCq5TMLEEoXRz3bwvr6uK1rr3Ns?=
 =?iso-8859-2?Q?yRSBerbmJD/ZZ+ObnNDbOOH2iCkHUJuVJxvO43eV7MHOp354KyauFmaAnx?=
 =?iso-8859-2?Q?ve3W8QuXW9HC8E002cKp+JmxPMtAaet0UYmffOQ/QtH9pwqs4RWURUqq10?=
 =?iso-8859-2?Q?AjWtBDSOgaBz07nb/wVUnhjGu3IlwbuOc05yLo7NAt+ogtQuPheZLWdkse?=
 =?iso-8859-2?Q?sVJEQXE+iIsU6NtdDfGyvgqpPx+wEai/fzTe1OsBTT3g4ISw8I0lqUo7PN?=
 =?iso-8859-2?Q?Ui58IOsGbxGXrkTbfHasebGXowPe7ji1AbBtVYVvz/fA7riU7f6beYLRg1?=
 =?iso-8859-2?Q?s8CRYhMj5gncWcknGIRth3Ni/LpRDlE3jvW0TIByQodKFwcoTNRcZqS9VZ?=
 =?iso-8859-2?Q?u3BmU+kB3fay6joTlS1WDA4diI9X9Pduq+SPZuk3EqHOLxb3YEP2NNMM+V?=
 =?iso-8859-2?Q?F9ehoScC422VY4fWpfpEaSZpNiOMQNq0233ZGVagJMez1oEpHJolJ4IYDF?=
 =?iso-8859-2?Q?rr95lC/zxpoLNZwcwqL5nHwh+kfByty09Vl9v6IhYVaw416rCIM5swf9cr?=
 =?iso-8859-2?Q?cPUHa7lW/29d0PAAhUgphYMjq79TEGuuu+U9e5RQGvksOA26HWqQdVvcN0?=
 =?iso-8859-2?Q?+WW1bi3sCAWfoKq6H5qjbVJe21oBV3lx6AnX6rS+XSG4QMSETxmaFEKKVb?=
 =?iso-8859-2?Q?7y5luHp8/I+Y8wqeUtKPqJ5rH2x/El887tArDaXVwW1B6ayD3B+SPdK+E5?=
 =?iso-8859-2?Q?ju2AWJVNKsxRVZOx/Fi/WE971MHiHUvsR/yupHVmPZC/6Ewd+LlaC1Q8uA?=
 =?iso-8859-2?Q?iV1i/kX1mV6VgVa4nc14YAcu9qryk57wAI+Wd+gH+oypoZd76+5cQufEzy?=
 =?iso-8859-2?Q?1EOlIiZCP+WpsYf5xLKPUCNLz49r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?JAcZu+XLiUOU8CJSSgwLGu7Y/XMu8k1WUI7Ah4cqVJUMBWde4kmxiTEO9K?=
 =?iso-8859-2?Q?dpJ5rZhOLpU5T9t2I/XlB3US7ufDrG0lM/DZfTCqdaK946hnz5F77s3wKJ?=
 =?iso-8859-2?Q?qgMA0wh2jdBFePzNXbR77En+zJXbyV1ndr+UumsF8SMXKQJ+OOdSR8UrSN?=
 =?iso-8859-2?Q?RklHn/G95gf/JEC5Pdn9PYix/KgqLWjYnGNlXVniFqQzmiQWxxn4ht70VM?=
 =?iso-8859-2?Q?KVEpzpUuas1b+v/EjYw8umW4FzWillX9WIeKnPt/6oQBFIJI/oLhWHdQP1?=
 =?iso-8859-2?Q?wnDX4bYaOllhPkyzIUDdEAo0NLx6N78O8eMe8ZJmYBnW2JmZXA2nqFIXpP?=
 =?iso-8859-2?Q?IuZUYiIFNz+bkdMYmPth6KYoNyyeT22qA89rVpsfDxgYbRNhk+PEGwIJTg?=
 =?iso-8859-2?Q?EUmtoXbbYR/FobrnsouXDWjP1UYOdDAcAqbXlCqucsdi+lqasmhosWEH6D?=
 =?iso-8859-2?Q?yNcXgt2c/bB/umXc8F0Faueqx5RwVzzx1kJs3F9ENKkf1aAs988BbpP98s?=
 =?iso-8859-2?Q?Hs9lqXCsJKbR2SjsIP71J7dJzshIi1m/+MaiOcNcZZwmFLH6OA0oLN1v/R?=
 =?iso-8859-2?Q?gFzW/ELHRS0DbgWKB7GYozXa+3UMEldiHkSWT8gJ8bswch5/+t8VcYpSM2?=
 =?iso-8859-2?Q?7SxAuxLOsE4QePikmND7AeXMC6ojUIO228eQUOPqV8Q/DBI8skTva0pEq8?=
 =?iso-8859-2?Q?zvS9imhV+clIJAH2JfiiDhLUVs2sscc4qUGi7J2MtsE/vr2xHwA4aYNEAH?=
 =?iso-8859-2?Q?6yrdru3DI77uvaD6At6OwOqH8Cmm7+UoYAq8DCO9E8LN6OJrIuO2BtQ4pM?=
 =?iso-8859-2?Q?zCcBbB7unQO+pQnEjPMFLwaweL6TuXmQ6cYEaSaS2pEssJFr1F8vb617QA?=
 =?iso-8859-2?Q?uT/5s+cP16uCXXJFqfF3HTg9YOlpH/R/l6hTu4a/BhcvDzGOiSOjsgsPIi?=
 =?iso-8859-2?Q?n9HTEQdHTjI25vY7N5PqZRdEsd8G4jP3CZT8lPbyLaEWO+vCshV22lTRxr?=
 =?iso-8859-2?Q?L1R9JCkMR7q2rtXScfGH7K7h/L8Y4ssMradPA8ycNfEVRJ9hs7vFneUsaZ?=
 =?iso-8859-2?Q?NjLQJ46yxpyfzQipPYwIHLDKqzhQa/+bo1lTBGm4YOEMP318iH+ibcrv5q?=
 =?iso-8859-2?Q?R1IVAFTppmRUMzxJLuJTqV57wDRNmFlU7iqH65Jni/Bvxaf6pbLIE7shYi?=
 =?iso-8859-2?Q?/2BGpuUbA4hZwANp5E2Ih0hTWre1X0SeJHcQSXLAbEfTlpiVg7+yPt6E8N?=
 =?iso-8859-2?Q?JRr22MREJHr68n99H9VNcbUoTQWVXswgoHEiBGZHzfX7HKaT4Yc7Lfh/ek?=
 =?iso-8859-2?Q?75nIHJeeC9hhA4SXFNcxHI4uVyIrmRngkUolr2urenyu5zezfaxO8JmDX4?=
 =?iso-8859-2?Q?euhetnR8XyZRSStChswMTaP4l+NvTgcbWtuVl/Qe+7Q+bANcHMFtChFlcX?=
 =?iso-8859-2?Q?rNZDbbAepHlFEvJYUvQOhkjbDJ5+ve7TfD5nwyLfqN6vDPi+FVRCaB0GDX?=
 =?iso-8859-2?Q?K2I1JeGZQuGp30dM9ISX8xW5V+CTM78+bCoYjXzG4dt2onHVAGTQagC4Xu?=
 =?iso-8859-2?Q?0sHGJ1xqsQUIK7WWDvUVIyf7n4jVA4sIYkNo5AI1i7GyLjrvEd2IlwNxsF?=
 =?iso-8859-2?Q?Q9PMXYfRADkiwN7AmZyMvDbaLqpemSwu9Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf75da7-1b8e-4777-1265-08de2304d313
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 22:34:36.0943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzy1shonmI5zJGs1dmaG8CrCP6foCu3hlDlOh8wFz+DyMGfoDNvNl+htR9RXXM+Thcff9uKfnLugIX4fvwAgxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7755
X-Outbound-SMTP-Client: 173.37.147.251, alln-opgw-3.cisco.com
X-Outbound-Node: alln-l-core-08.cisco.com

On Thursday, November 13, 2025 6:33 AM, Andy Shevchenko <andriy.shevchenko@=
linux.intel.com> wrote:
>
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/scsi/fnic/fnic_trace.c | 52 ++++++++++++++--------------------
> 1 file changed, 22 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trac=
e.c
> index cdc6b12b1ec2..0a849a195a8e 100644
> --- a/drivers/scsi/fnic/fnic_trace.c
> +++ b/drivers/scsi/fnic/fnic_trace.c
> @@ -138,9 +138,8 @@ int fnic_get_trace_data(fnic_dbgfs_t *fnic_dbgfs_prt)
> */
> len +=3D scnprintf(fnic_dbgfs_prt->buffer + len,
> (trace_max_pages * PAGE_SIZE * 3) - len,
> -                               "%16llu.%09lu %-50s %8x %8x %16llx %16llx=
 "
> -                               "%16llx %16llx %16llx\n", (u64)val.tv_sec=
,
> -                               val.tv_nsec, str, tbp->host_no, tbp->tag,
> +                               "%ptSp %-50s %8x %8x %16llx %16llx %16llx=
 %16llx %16llx\n",
> +                               &val, str, tbp->host_no, tbp->tag,
> tbp->data[0], tbp->data[1], tbp->data[2],
> tbp->data[3], tbp->data[4]);
> rd_idx++;
> @@ -180,9 +179,8 @@ int fnic_get_trace_data(fnic_dbgfs_t *fnic_dbgfs_prt)
> */
> len +=3D scnprintf(fnic_dbgfs_prt->buffer + len,
> (trace_max_pages * PAGE_SIZE * 3) - len,
> -                               "%16llu.%09lu %-50s %8x %8x %16llx %16llx=
 "
> -                               "%16llx %16llx %16llx\n", (u64)val.tv_sec=
,
> -                               val.tv_nsec, str, tbp->host_no, tbp->tag,
> +                               "%ptSp %-50s %8x %8x %16llx %16llx %16llx=
 %16llx %16llx\n",
> +                               &val, str, tbp->host_no, tbp->tag,
> tbp->data[0], tbp->data[1], tbp->data[2],
> tbp->data[3], tbp->data[4]);
> rd_idx++;
> @@ -215,30 +213,26 @@ int fnic_get_stats_data(struct stats_debug_info *de=
bug,
> {
> int len =3D 0;
> int buf_size =3D debug->buf_size;
> -     struct timespec64 val1, val2;
> +     struct timespec64 val, val1, val2;
> int i =3D 0;
>
> -     ktime_get_real_ts64(&val1);
> +     ktime_get_real_ts64(&val);
> len =3D scnprintf(debug->debug_buffer + len, buf_size - len,
> "------------------------------------------\n"
> "\t\tTime\n"
> "------------------------------------------\n");
>
> +     val1 =3D timespec64_sub(val, stats->stats_timestamps.last_reset_tim=
e);
> +     val2 =3D timespec64_sub(val, stats->stats_timestamps.last_read_time=
);
> len +=3D scnprintf(debug->debug_buffer + len, buf_size - len,
> -             "Current time :          [%lld:%ld]\n"
> -             "Last stats reset time:  [%lld:%09ld]\n"
> -             "Last stats read time:   [%lld:%ld]\n"
> -             "delta since last reset: [%lld:%ld]\n"
> -             "delta since last read:  [%lld:%ld]\n",
> -     (s64)val1.tv_sec, val1.tv_nsec,
> -     (s64)stats->stats_timestamps.last_reset_time.tv_sec,
> -     stats->stats_timestamps.last_reset_time.tv_nsec,
> -     (s64)stats->stats_timestamps.last_read_time.tv_sec,
> -     stats->stats_timestamps.last_read_time.tv_nsec,
> -     (s64)timespec64_sub(val1, stats->stats_timestamps.last_reset_time).=
tv_sec,
> -     timespec64_sub(val1, stats->stats_timestamps.last_reset_time).tv_ns=
ec,
> -     (s64)timespec64_sub(val1, stats->stats_timestamps.last_read_time).t=
v_sec,
> -     timespec64_sub(val1, stats->stats_timestamps.last_read_time).tv_nse=
c);
> +                      "Current time :          [%ptSp]\n"
> +                      "Last stats reset time:  [%ptSp]\n"
> +                      "Last stats read time:   [%ptSp]\n"
> +                      "delta since last reset: [%ptSp]\n"
> +                      "delta since last read:  [%ptSp]\n",
> +                      &val,
> +                      &stats->stats_timestamps.last_reset_time, &val1,
> +                      &stats->stats_timestamps.last_read_time, &val2);
>
> stats->stats_timestamps.last_read_time =3D val1;
>
> @@ -416,8 +410,8 @@ int fnic_get_stats_data(struct stats_debug_info *debu=
g,
> jiffies_to_timespec64(stats->misc_stats.last_ack_time, &val2);
>
> len +=3D scnprintf(debug->debug_buffer + len, buf_size - len,
> -               "Last ISR time: %llu (%8llu.%09lu)\n"
> -               "Last ACK time: %llu (%8llu.%09lu)\n"
> +               "Last ISR time: %llu (%ptSp)\n"
> +               "Last ACK time: %llu (%ptSp)\n"
> "Max ISR jiffies: %llu\n"
> "Max ISR time (ms) (0 denotes < 1 ms): %llu\n"
> "Corr. work done: %llu\n"
> @@ -437,10 +431,8 @@ int fnic_get_stats_data(struct stats_debug_info *deb=
ug,
> "Number of rport not ready: %lld\n"
> "Number of receive frame errors: %lld\n"
> "Port speed (in Mbps): %lld\n",
> -               (u64)stats->misc_stats.last_isr_time,
> -               (s64)val1.tv_sec, val1.tv_nsec,
> -               (u64)stats->misc_stats.last_ack_time,
> -               (s64)val2.tv_sec, val2.tv_nsec,
> +               (u64)stats->misc_stats.last_isr_time, &val1,
> +               (u64)stats->misc_stats.last_ack_time, &val2,
> (u64)atomic64_read(&stats->misc_stats.max_isr_jiffies),
> (u64)atomic64_read(&stats->misc_stats.max_isr_time_ms),
> (u64)atomic64_read(&stats->misc_stats.corr_work_done),
> @@ -857,8 +849,8 @@ void copy_and_format_trace_data(struct fc_trace_hdr *=
tdata,
> len =3D *orig_len;
>
> len +=3D scnprintf(fnic_dbgfs_prt->buffer + len, max_size - len,
> -                      "%ptTs.%09lu ns%8x       %c%8x\t",
> -                      &tdata->time_stamp.tv_sec, tdata->time_stamp.tv_ns=
ec,
> +                      "%ptSs ns%8x       %c%8x\t",
> +                      &tdata->time_stamp,
> tdata->host_no, tdata->frame_type, tdata->frame_len);
>
> fc_trace =3D (char *)FC_TRACE_ADDRESS(tdata);
> --
> 2.50.1
>
>

Acked-by: Karan Tilak Kumar <kartilak@cisco.com>

Thanks for the change, Andy.

Can you please advise how I can compile test this change?

Regards,
Karan

