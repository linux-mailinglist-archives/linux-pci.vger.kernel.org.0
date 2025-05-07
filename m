Return-Path: <linux-pci+bounces-27388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CB5AAE6A2
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 18:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0E7172C10
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719A28B7CC;
	Wed,  7 May 2025 16:28:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5998E4B1E4B;
	Wed,  7 May 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635303; cv=none; b=a7sR0MsWgow1thG8+Ta5YvkilTb/5H0GueIwjm+AEV2pagruX1nOcIszqDOSLDWMeEbBBdIqU5mwhv3dDsIdPVb11UVjCdIt7ZGo8VmgXt+H3IFdJbcLNbOmgsIufGZE/3GvM9PqnP211Qa1PDzTN6ApNw708yE0+3onttQn4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635303; c=relaxed/simple;
	bh=BpD9FuhmPW6xsUA5blbXqYxPubWoNLv1alehOh2bprU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AaP6KTf8xrxJGU5twrWCfmyaoq5roDi7yjrM9HkA5zZIXlylFvLUhBW1ORiE4Wp/qJkX++8lk8hghZNlL/gRqRKkQEhuTh1/iY061DEou9iy4wh7AMY6eDNZp5NRVoH1LyDMxawVsnJG+nqBOyBY2AJsK5Xpbvim82ptJTsLhqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zt0v80KM6z6M4f1;
	Thu,  8 May 2025 00:23:48 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E1971402A5;
	Thu,  8 May 2025 00:28:19 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 May 2025 18:28:19 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 7 May 2025 18:28:19 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "mahesh@linux.ibm.com" <mahesh@linux.ibm.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "oohall@gmail.com"
	<oohall@gmail.com>, "Benjamin.Cheatham@amd.com" <Benjamin.Cheatham@amd.com>,
	"rrichter@amd.com" <rrichter@amd.com>, "nathan.fontenot@amd.com"
	<nathan.fontenot@amd.com>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "lukas@wunner.de"
	<lukas@wunner.de>, "ming.li@zohomail.com" <ming.li@zohomail.com>,
	"PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>
Subject: RE: [PATCH v8 11/16] cxl/pci: Unifi CXL trace logging for CXL
 Endpoints and CXL Ports
Thread-Topic: [PATCH v8 11/16] cxl/pci: Unifi CXL trace logging for CXL
 Endpoints and CXL Ports
Thread-Index: AQHbnruCvt+7t4Pcrkejo0BVy/biabOxfwcAgBYbz1A=
Date: Wed, 7 May 2025 16:28:19 +0000
Message-ID: <c21ab32695484da996df84988dddbd0d@huawei.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-12-terry.bowman@amd.com>
 <20250423174442.000039b0@huawei.com>
In-Reply-To: <20250423174442.000039b0@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 23 April 2025 17:45
>To: Terry Bowman <terry.bowman@amd.com>
>Cc: linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>pci@vger.kernel.org; nifan.cxl@gmail.com; dave@stgolabs.net;
>dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com=
;
>dan.j.williams@intel.com; bhelgaas@google.com; mahesh@linux.ibm.com;
>ira.weiny@intel.com; oohall@gmail.com; Benjamin.Cheatham@amd.com;
>rrichter@amd.com; nathan.fontenot@amd.com;
>Smita.KoralahalliChannabasappa@amd.com; lukas@wunner.de;
>ming.li@zohomail.com; PradeepVineshReddy.Kodamati@amd.com; Shiju Jose
><shiju.jose@huawei.com>
>Subject: Re: [PATCH v8 11/16] cxl/pci: Unifi CXL trace logging for CXL End=
points
>and CXL Ports
>
>On Wed, 26 Mar 2025 20:47:12 -0500
>Terry Bowman <terry.bowman@amd.com> wrote:
>
>Unify.
>
>
>> CXL currently has separate trace routines for CXL Port errors and CXL
>> Endpoint errors. This is inconvnenient for the user because they must
>> enable 2 sets of trace routines. Make updates to the trace logging
>> such that a single trace routine logs both CXL Endpoint and CXL Port
>> protocol errors.
>>
>> Also, CXL RAS errors are currently logged using the associated CXL
>> port's name returned from devname(). They are typically named with
>> 'port1', 'port2', etc. to indicate the hierarchial location in the CXL t=
opology.
>> But, this doesn't clearly indicate the CXL card or slot reporting the
>> error.
>>
>> Update the logging to also log the corresponding PCIe devname. This
>> will give a PCIe SBDF or ACPI object name (in case of CXL HB). This
>> will provide details helping users understand which physical slot and
>> card has the error.
>>
>> Below is example output after making these changes.
>>
>> Correctable error example output:
>> cxl_port_aer_correctable_error: device=3Dport1 (0000:0c:00.0) parent=3Dr=
oot0
>(pci0000:0c) status=3D'Received Error From Physical Layer'
>>
>> Uncorrectable error example output:
>> cxl_port_aer_uncorrectable_error: device=3Dport1 (0000:0c:00.0) parent=
=3Droot0
>(pci0000:0c) status: 'Memory Byte Enable Parity Error' first_error: 'Memor=
y
>Byte Enable Parity Error'
>
>I'm not sure the pcie parent is adding much... Why bother with that?
>
>Shiju, is this going to affect rasdaemon handling?

Hi Jonathan,

Yes. Renaming the existing fields in the trace events will result failure
while parsing the fields in the rasdaemon.

>
>I'd assume we can't just rename fields in the tracepoints and combining th=
em
>will also presumably make a mess?
>
>Jonathan
>
[...]
>>

Thanks,
Shiju


