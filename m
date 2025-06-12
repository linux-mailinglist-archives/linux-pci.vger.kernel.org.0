Return-Path: <linux-pci+bounces-29565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D52AD781D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDA21623A2
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4291B299AB1;
	Thu, 12 Jun 2025 16:25:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653E299A82;
	Thu, 12 Jun 2025 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745511; cv=none; b=dc5h6dhf5a3QEJD94Fd2iqGTQyI0nP+g/ELa4H/8LauHxY4tnosf6X7Z9NSn+Lh0OlOjWESpWlnOqe/h0F/UGZqsZ7cnJQNneBN2YYMU+9F9LdgV7eLiepUJ9eafXdGa6VdWed95SB0Xj3dccHEFgvGJP251YiOj0ylnpk0CXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745511; c=relaxed/simple;
	bh=gF8eAEg3lX0bt5dk5RcgF5xlLni342NkXfAz0oXZ17g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kn1KW2ewcgu6EpVnCFQURMCfUKxS3sq4EPyiHChei5Hla7mHH7m4QFqkgRTtn0PCvCHPXF4LZOw6Zwr0KP0qUDXbl1JIiPdwfhABAOF/ZQg/V10eZucdJjy+Xi85a3TTYAsEcXygUisWLxM0GVlgEg50ZqUURdFqIsG6+ZuX6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ7CW0Kz1z6M51y;
	Fri, 13 Jun 2025 00:24:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E00E140276;
	Fri, 13 Jun 2025 00:25:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 18:25:03 +0200
Date: Thu, 12 Jun 2025 17:25:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: Shiju Jose <shiju.jose@huawei.com>, "PradeepVineshReddy.Kodamati@amd.com"
	<PradeepVineshReddy.Kodamati@amd.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "kobayashi.da-06@fujitsu.com"
	<kobayashi.da-06@fujitsu.com>, "yanfei.xu@intel.com" <yanfei.xu@intel.com>,
	"rrichter@amd.com" <rrichter@amd.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "colyli@suse.de" <colyli@suse.de>,
	"uaisheng.ye@intel.com" <uaisheng.ye@intel.com>,
	"fabio.m.de.francesco@linux.intel.com"
	<fabio.m.de.francesco@linux.intel.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>
Subject: Re: [PATCH v9 10/16] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
Message-ID: <20250612172502.0000692e@huawei.com>
In-Reply-To: <e319c9b2-742d-4fbf-8092-90a4f96d7980@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
	<20250603172239.159260-11-terry.bowman@amd.com>
	<959acc682e6e4b52ac0283b37ee21026@huawei.com>
	<3e022f34-ad65-4caa-9321-c181bb8ae676@amd.com>
	<e319c9b2-742d-4fbf-8092-90a4f96d7980@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 6 Jun 2025 10:24:25 -0500
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 6/6/2025 9:41 AM, Bowman, Terry wrote:
> >
> > On 6/6/2025 4:08 AM, Shiju Jose wrote:  
> >>> -----Original Message-----
> >>> From: Terry Bowman <terry.bowman@amd.com>
> >>> Sent: 03 June 2025 18:23
> >>> To: PradeepVineshReddy.Kodamati@amd.com; dave@stgolabs.net; Jonathan
> >>> Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
> >>> alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
> >>> dan.j.williams@intel.com; bhelgaas@google.com; bp@alien8.de;
> >>> ming.li@zohomail.com; Shiju Jose <shiju.jose@huawei.com>;
> >>> dan.carpenter@linaro.org; Smita.KoralahalliChannabasappa@amd.com;
> >>> kobayashi.da-06@fujitsu.com; terry.bowman@amd.com; yanfei.xu@intel.com;
> >>> rrichter@amd.com; peterz@infradead.org; colyli@suse.de;
> >>> uaisheng.ye@intel.com; fabio.m.de.francesco@linux.intel.com;
> >>> ilpo.jarvinen@linux.intel.com; yazen.ghannam@amd.com; linux-
> >>> cxl@vger.kernel.org; linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
> >>> Subject: [PATCH v9 10/16] cxl/pci: Unify CXL trace logging for CXL Endpoints and
> >>> CXL Ports
> >>>
> >>> CXL currently has separate trace routines for CXL Port errors and CXL Endpoint
> >>> errors. This is inconvenient for the user because they must enable
> >>> 2 sets of trace routines. Make updates to the trace logging such that a single
> >>> trace routine logs both CXL Endpoint and CXL Port protocol errors.
> >>>
> >>> Rename the 'host' field from the CXL Endpoint trace to 'parent' in the unified
> >>> trace routines. 'host' does not correctly apply to CXL Port devices. Parent is more
> >>> general and applies to CXL Port devices and CXL Endpoints.
> >>>
> >>> Add serial number parameter to the trace logging. This is used for EPs and 0 is
> >>> provided for CXL port devices without a serial number.
> >>>
> >>> Below is output of correctable and uncorrectable protocol error logging.
> >>> CXL Root Port and CXL Endpoint examples are included below.
> >>>
> >>> Root Port:
> >>> cxl_aer_correctable_error: device=0000:0c:00.0 parent=pci0000:0c serial: 0
> >>> status='CRC Threshold Hit'
> >>> cxl_aer_uncorrectable_error: device=0000:0c:00.0 parent=pci0000:0c serial: 0
> >>> status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity
> >>> Error'
> >>>
> >>> Endpoint:
> >>> cxl_aer_correctable_error: device=mem3 parent=0000:0f:00.0 serial=0
> >>> status='CRC Threshold Hit'
> >>> cxl_aer_uncorrectable_error: device=mem3 parent=0000:0f:00.0 serial: 0
> >>> status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity
> >>> Error'
> >>>
> >>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >>> ---
> >>> drivers/cxl/core/pci.c   | 18 +++++----
> >>> drivers/cxl/core/ras.c   | 14 ++++---
> >>> drivers/cxl/core/trace.h | 84 +++++++++-------------------------------
> >>> 3 files changed, 37 insertions(+), 79 deletions(-)
> >>>
> >>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c index
> >>> 186a5a20b951..0f4c07fd64a5 100644
> >>> --- a/drivers/cxl/core/pci.c
> >>> +++ b/drivers/cxl/core/pci.c
> >>> @@ -664,7 +664,7 @@ void read_cdat_data(struct cxl_port *port)  }
> >>> EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
> >>>  
> >> [...]  
> >>> static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data
> >>> *data) diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h index
> >>> 25ebfbc1616c..8c91b0f3d165 100644
> >>> --- a/drivers/cxl/core/trace.h
> >>> +++ b/drivers/cxl/core/trace.h
> >>> @@ -48,49 +48,22 @@
> >>> 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
> >>> )
> >>>
> >>> -TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> >>> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> >>> -	TP_ARGS(dev, status, fe, hl),
> >>> -	TP_STRUCT__entry(
> >>> -		__string(device, dev_name(dev))
> >>> -		__string(host, dev_name(dev->parent))
> >>> -		__field(u32, status)
> >>> -		__field(u32, first_error)
> >>> -		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> >>> -	),
> >>> -	TP_fast_assign(
> >>> -		__assign_str(device);
> >>> -		__assign_str(host);
> >>> -		__entry->status = status;
> >>> -		__entry->first_error = fe;
> >>> -		/*
> >>> -		 * Embed the 512B headerlog data for user app retrieval and
> >>> -		 * parsing, but no need to print this in the trace buffer.
> >>> -		 */
> >>> -		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> >>> -	),
> >>> -	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
> >>> -		  __get_str(device), __get_str(host),
> >>> -		  show_uc_errs(__entry->status),
> >>> -		  show_uc_errs(__entry->first_error)
> >>> -	)
> >>> -);
> >>> -
> >>> TRACE_EVENT(cxl_aer_uncorrectable_error,
> >>> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32
> >>> *hl),
> >>> -	TP_ARGS(cxlmd, status, fe, hl),
> >>> +	TP_PROTO(struct device *dev, u64 serial, u32 status, u32 fe,
> >>> +		 u32 *hl),
> >>> +	TP_ARGS(dev, serial, status, fe, hl),
> >>> 	TP_STRUCT__entry(
> >>> -		__string(memdev, dev_name(&cxlmd->dev))
> >>> -		__string(host, dev_name(cxlmd->dev.parent))
> >>> +		__string(name, dev_name(dev))
> >>> +		__string(parent, dev_name(dev->parent))  
> >> Hi Terry,
> >>
> >> As we pointed out in v8, renaming the fields "memdev" to "name" and "host" to "parent"
> >> causes issues and failures in userspace rasdaemon  while parsing the trace event data.
> >> Additionally, we can't rename these fields in rasdaemon  due to backward compatibility.  
> > Yes, I remember but didn't understand why other SW couldn't be updated to handle. I will
> > change as you request but many people will be confused why a port device's name is labeled
> > as a memdev. memdev is only correct for EPs and does not correctly reflect *any* of the
> > other CXL device types (RP, USP, DSP).

RAS trace points are ABI so you can introduce whatever you like that is new, but you can't
remove or rename existing elements. If userspace breaks (which Shiju is confirming it will)
and anyone reports the regression, then you get grumpy Linus.

Test this stuff against upstream rasdaemon. It's easy and means things
like this don't sneak in - various cloud vendors have stated it's what their
stacks are based on, so they will see this in production if they get a mismatch.

https://github.com/mchehab/rasdaemon/blob/master/ras-cxl-handler.c#L354

It think this will error out if an AER UE does not contain the memdev field.

So your options are a new tracepoint, or leave those fields in place and just
let them contain whatever is most useful. If you go with new tracepoint you
still should generate the old one as well if it is enabled.  Note that
even adding fields can be a bit painful as it requires some DB restructuring
on an upgrade of rasdaemon (or dumping existing logs and starting from scratch).

+CC Mauro in case I've missed any other ways to deal with this change.


> >  
> >>> 		__field(u64, serial)
> >>> 		__field(u32, status)
> >>> 		__field(u32, first_error)
> >>> 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> >>> 	),
> >>> 	TP_fast_assign(
> >>> -		__assign_str(memdev);
> >>> -		__assign_str(host);
> >>> -		__entry->serial = cxlmd->cxlds->serial;
> >>> +		__assign_str(name);
> >>> +		__assign_str(parent);
> >>> +		__entry->serial = serial;
> >>> 		__entry->status = status;
> >>> 		__entry->first_error = fe;
> >>> 		/*
> >>> @@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
> >>> 		 */
> >>> 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> >>> 	),
> >>> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error:
> >>> '%s'",
> >>> -		  __get_str(memdev), __get_str(host), __entry->serial,
> >>> +	TP_printk("device=%s parent=%s serial=%lld status='%s'
> >>> first_error='%s'",
> >>> +		  __get_str(name), __get_str(parent), __entry->serial,
> >>> 		  show_uc_errs(__entry->status),
> >>> 		  show_uc_errs(__entry->first_error)
> >>> 	)
> >>> @@ -124,42 +97,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
> >>> 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer"
> >>> }	\
> >>> )
> >>>
> >>> -TRACE_EVENT(cxl_port_aer_correctable_error,
> >>> -	TP_PROTO(struct device *dev, u32 status),
> >>> -	TP_ARGS(dev, status),
> >>> -	TP_STRUCT__entry(
> >>> -		__string(device, dev_name(dev))
> >>> -		__string(host, dev_name(dev->parent))
> >>> -		__field(u32, status)
> >>> -	),
> >>> -	TP_fast_assign(
> >>> -		__assign_str(device);
> >>> -		__assign_str(host);
> >>> -		__entry->status = status;
> >>> -	),
> >>> -	TP_printk("device=%s host=%s status='%s'",
> >>> -		  __get_str(device), __get_str(host),
> >>> -		  show_ce_errs(__entry->status)
> >>> -	)
> >>> -);
> >>> -
> >>> TRACE_EVENT(cxl_aer_correctable_error,
> >>> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
> >>> -	TP_ARGS(cxlmd, status),
> >>> +	TP_PROTO(struct device *dev, u64 serial, u32 status),
> >>> +	TP_ARGS(dev, serial, status),
> >>> 	TP_STRUCT__entry(
> >>> -		__string(memdev, dev_name(&cxlmd->dev))
> >>> -		__string(host, dev_name(cxlmd->dev.parent))
> >>> +		__string(name, dev_name(dev))
> >>> +		__string(parent, dev_name(dev->parent))  
> >> Renaming these fields is an issue for userspace as mentioned above 
> >> in cxl_aer_uncorrectable_error.  
> > I understand, I'll revert as you request.
> >
> > Terry  
> 
> I'll update the commit message with explanation for leaving as-is.
> 
> Terry
> >>> 		__field(u64, serial)
> >>> 		__field(u32, status)
> >>> 	),
> >>> 	TP_fast_assign(
> >>> -		__assign_str(memdev);
> >>> -		__assign_str(host);
> >>> -		__entry->serial = cxlmd->cxlds->serial;
> >>> +		__assign_str(name);
> >>> +		__assign_str(parent);
> >>> +		__entry->serial = serial;
> >>> 		__entry->status = status;
> >>> 	),
> >>> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
> >>> -		  __get_str(memdev), __get_str(host), __entry->serial,
> >>> +	TP_printk("device=%s parent=%s serial=%lld status='%s'",
> >>> +		  __get_str(name), __get_str(parent), __entry->serial,
> >>> 		  show_ce_errs(__entry->status)
> >>> 	)
> >>> );
> >>> --
> >>> 2.34.1  
> >> Thanks,
> >> Shiju  
> 


