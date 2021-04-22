Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62AA367819
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 05:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhDVDuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 23:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDVDuL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Apr 2021 23:50:11 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC2C06138B
        for <linux-pci@vger.kernel.org>; Wed, 21 Apr 2021 20:49:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d124so30717638pfa.13
        for <linux-pci@vger.kernel.org>; Wed, 21 Apr 2021 20:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KlLhNuqFuzAH3Dvaau9RXCpdk7wAfkXaC/QsSXDFqAI=;
        b=lOEkPYQi9bBU+LVprM/puFZ5zkeovcvDT4PZOtupVJu7etYqUXQ8HKLZXR5LoYY+s7
         64kdrulRwsmfSLRGYjKmtKdtG8Z3+8sZiSBupH5WBRipImvAqPXSKSHYYpC1h0eyAbdy
         MQJTNX8tO3ZxpsxAgmmluMqgqxWC2VoghvCyXOi1N+OKJrvo2iW7APMWpfpRAeT3Ku6i
         MkpKVoMLD3sBQq5Vkp4AVqm80/trIS5+ylJC74J/HZTKEJVvFvsz1wakXeYkQ3Wmfc1F
         Y6SS45I1Wzyq0bac6VmDi5nLKHC1HfIElsvqPmx2XbzORt6spcWEjc4tlUAy1oKs/1Ma
         lGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KlLhNuqFuzAH3Dvaau9RXCpdk7wAfkXaC/QsSXDFqAI=;
        b=pmVlJbdp4dFnjEsItvMCoyjxr/YYo6g7xUSdaIcTdSAu7OJO2k9Bk+cCd+9/7dTJMc
         5Dp6rGUPUQznbqTAstiJuGpJJfCQBNVrNBGWI4hXoI7iWGIUeA0LdPsA1B6iacssDnRF
         fNOAq+wyteD77I3RnYblujJUYfJPcPZPGwcue2CTpeaCwT1mmgUWSw3r4g3imNf4Uo4R
         p/qS9LogKCaOcdPi6Fuxo9QfhqqxpTH5Lrj4E33e+JOAr/C5qIQSI/6LUjrQyB/N6qBO
         saVr+J7AY3Uwf115gYMGKuSZTBBi6EnGVDcP3CNSwzZSrt/exh4Mys581FkjdvaweOFh
         //aw==
X-Gm-Message-State: AOAM530dKIKSAAyyo0HXddiJM7hl5SrUmJIGeQ+8wH6DOeD65tQ3F0UN
        ZhN78M5eYPXnz0jE+d7Op/te+w==
X-Google-Smtp-Source: ABdhPJym7+h50FogD5nM2qAbk/SlBPGipAUlsCRbWIm5H3VkrKDoP+0peLdasUkLw24eRrtr2OV+pQ==
X-Received: by 2002:aa7:80c9:0:b029:249:cac5:e368 with SMTP id a9-20020aa780c90000b0290249cac5e368mr1393699pfn.12.1619063376568;
        Wed, 21 Apr 2021 20:49:36 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id i66sm719546pgd.8.2021.04.21.20.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 20:49:35 -0700 (PDT)
Date:   Thu, 22 Apr 2021 11:49:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-pci@vger.kernel.org,
        helgaas@kernel.org, gregkh@linuxfoundation.org,
        lorenzo.pieralisi@arm.com, will@kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, jonathan.cameron@huawei.com,
        song.bao.hua@hisilicon.com, john.garry@huawei.com,
        prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH RESEND 0/4] Add support for HiSilicon PCIe Tune and Trace
 device
Message-ID: <20210422034929.GA13004@leoy-ThinkPad-X240s>
References: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
 <8735vpf20c.fsf@ashishki-desk.ger.corp.intel.com>
 <628f2f4a-03ce-a646-bf27-d6836baca425@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628f2f4a-03ce-a646-bf27-d6836baca425@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 19, 2021 at 09:03:18PM +0800, Yicong Yang wrote:
> On 2021/4/17 21:56, Alexander Shishkin wrote:
> > Yicong Yang <yangyicong@hisilicon.com> writes:
> > 
> >> The reason for not using perf is because there is no current support
> >> for uncore tracing in the perf facilities.
> > 
> > Not unless you count
> > 
> > $ perf list|grep -ic uncore
> > 77
> > 
> 
> these are uncore events probably do not support sampling.
> 
> I tried on x86:
> 
> # ./perf record -e uncore_imc_0/cas_count_read/
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc_0/cas_count_read/).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> For HiSilicon uncore PMUs, we don't support uncore sampling:
> 
> 'The current driver does not support sampling. So "perf record" is unsupported. ' [1]
> 
> and also in another PMU:
> 
> 'PMU doesn't support process specific events and cannot be used in sampling mode.' [2]
> 
> [1] Documentation/admin-guide/perf/hisi-pmu.rst
> [2] Documentation/admin-guide/perf/arm_dsu_pmu.rst

I did some debugging for this, and yes, it's related with the event
doesn't support sampling for these x86 uncore events.

So I can use below commands for the uncore event
'uncore_imc/data_reads/' in my experiment:

  # perf record -e 'uncore_imc/data_reads/' --no-samples -- ls
  # perf stat -e 'uncore_imc/data_reads/' -- ls

For your case, I think you need to write the callback
pmu::event_init(), it should not forbid any tracing even if set
sampling, just like other perf event drive for support AUX tracing.

> >> We have our own format
> >> of data and don't need perf doing the parsing.
> > 
> > Perf has AUX buffers, which are used for all kinds of own formats.
> > 
> 
> ok. we thought perf will break the data format but AUX buffers seems won't.
> do we need to add full support for tracing as well as parsing or it's ok for
> not parsing it through perf?

IMHO, this could divide into two parts.  The first part is to enable
perf drive with support AUX tracing, and perf tool can capture the trace
data.  The second part is to add the decoder in the perf tool so that
the developers can *consume* the trace data; for the decoder, you
could refer the codes:

  tools/perf/util/intel-pt-decoder/
  tools/perf/util/cs-etm-decoder/

Or Arm SPE case:

  tools/perf/util/arm-spe-decoder/

> >> A similar approach for implementing this function is ETM, which use
> >> sysfs for configuring and a character device for dumping data.
> > 
> > And also perf. One reason ETM has a sysfs interface is because the
> > driver predates perf's AUX buffers. Can't say if it's the only
> > reason. I'm assuming you're talking about Coresight ETM.

I am not the best person to give background for this.  Mathieu or Mike
could give more info for this.  From my undersanding, Sysfs nodes can
be used as knobs for configuration, but it's difficult for profiling.

Let's think about for the profiling, if one developer uses the Sysfs
for the setting and read out the trace data, these informations are
discrete.  If another developer wants to review the profiling result,
then all these info need to be shared together.

So we can benefit much from the perf tool for the usage, since all the
profiling context will be gathered (DSOs, hardware configuration which
can be saved into metadata), so the final profiling file can be easily
shared and more friendly for reviewing.

Thanks,
Leo
