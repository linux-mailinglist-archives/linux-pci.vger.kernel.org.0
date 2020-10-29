Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41729EF84
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 16:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgJ2PQi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgJ2PQh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 11:16:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5DAC0613D2
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 08:16:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g12so3162068wrp.10
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qGSa3lP6/VlSmTE6DEPynJHPtQdFaqjnszykI+jVN74=;
        b=q0B83+221jC3LV3D0vJiIdNgLHOJz8koX0+RGRVI53uJfSwkJ8GhR4JugF+mZ5GPqb
         ZVTDv8mDAYZYhPQ8hkXlcLD27dSXrp4lAJYYTgW5f0WQCB84W79ZgU2Iqx5VJfIKLCoE
         jKK2eBSS/Lvzh1DUAeQluJM3KuX5ma/PcZKXUkSkL6f8sz81XxPhZc2UziaorPMUZwdA
         xfhXKDLXC1lkj6AO73PtkssaMNoMDdcXSp9aRy13Of2jY4DRFx2YOa8plS0aX9VN8pho
         cgWWv8sETb2CVIs0HkhFj2AqtPjo2Lpg4bUWFrHB8z4qz1kyKkBN1nrmHs2E/WkwPHMO
         Wrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qGSa3lP6/VlSmTE6DEPynJHPtQdFaqjnszykI+jVN74=;
        b=oF13u/AdRImeMSvWeHJdqQUCutavuvysfVDUZC7I6/X+iz5uVtsgfZd8OaxQ5BoJZI
         jGjpplwtyg58o9rkespdUWJBUF02mlqEI5F/ARv7hwj4SxXSVxYIW4kQft2ZcJqNYLpa
         99rMN4NL78nTvD7dfGzNyoL1Gev3q6H04lzErRK/QAKdtII+DfvsjqURtKoQ003ejBgD
         Hccb9d7RKwvzacavOFxaHpLKPQWJAlrgru+1s74lmbXkKbAta7OWoVLo+qfa6YuOYoOj
         sWF/v6eH798twGUVcvZLv6elwQu4YR7k9R6E+zFvgHg1LhiL+7EJsJPPQiSsWGo5VJYn
         nlLA==
X-Gm-Message-State: AOAM530MuVNQ1bA6PO8A3r2ILxFxVhmsVe40mG/c0jAC2WwbjSwYZTHr
        ed9whJ5O9d/gsCxwcdiBE9iDYg==
X-Google-Smtp-Source: ABdhPJzefw8uLArrouGi05ZGHK+szXIoFAAlfWsu5Gv8UCGIFVRyIWlIQoYW4wfLbmouL31sRTqYwg==
X-Received: by 2002:a5d:694b:: with SMTP id r11mr6423143wrw.104.1603984596064;
        Thu, 29 Oct 2020 08:16:36 -0700 (PDT)
Received: from dell ([91.110.221.160])
        by smtp.gmail.com with ESMTPSA id e3sm5702386wrn.32.2020.10.29.08.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:16:35 -0700 (PDT)
Date:   Thu, 29 Oct 2020 15:16:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com,
        alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V9 0/5] Intel Platform Monitoring Technology
Message-ID: <20201029151633.GB4127@dell>
References: <20201029014449.14955-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029014449.14955-1-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Oct 2020, David E. Box wrote:

> Intel Platform Monitoring Technology (PMT) is an architecture for
> enumerating and accessing hardware monitoring capabilities on a device.
> With customers increasingly asking for hardware telemetry, engineers not
> only have to figure out how to measure and collect data, but also how to
> deliver it and make it discoverable. The latter may be through some device
> specific method requiring device specific tools to collect the data. This
> in turn requires customers to manage a suite of different tools in order to
> collect the differing assortment of monitoring data on their systems.  Even
> when such information can be provided in kernel drivers, they may require
> constant maintenance to update register mappings as they change with
> firmware updates and new versions of hardware. PMT provides a solution for
> discovering and reading telemetry from a device through a hardware agnostic
> framework that allows for updates to systems without requiring patches to
> the kernel or software tools.
> 
> PMT defines several capabilities to support collecting monitoring data from
> hardware. All are discoverable as separate instances of the PCIE Designated
> Vendor extended capability (DVSEC) with the Intel vendor code. The DVSEC ID
> field uniquely identifies the capability. Each DVSEC also provides a BAR
> offset to a header that defines capability-specific attributes, including
> GUID, feature type, offset and length, as well as configuration settings
> where applicable. The GUID uniquely identifies the register space of any
> monitor data exposed by the capability. The GUID is associated with an XML
> file from the vendor that describes the mapping of the register space along
> with properties of the monitor data. This allows vendors to perform
> firmware updates that can change the mapping (e.g. add new metrics) without
> requiring any changes to drivers or software tools. The new mapping is
> confirmed by an updated GUID, read from the hardware, which software uses
> with a new XML.
> 
> The current capabilities defined by PMT are Telemetry, Watcher, and
> Crashlog.  The Telemetry capability provides access to a continuous block
> of read only data. The Watcher capability provides access to hardware
> sampling and tracing features. Crashlog provides access to device crash
> dumps.  While there is some relationship between capabilities (Watcher can
> be configured to sample from the Telemetry data set) each exists as stand
> alone features with no dependency on any other. The design therefore splits
> them into individual, capability specific drivers. MFD is used to create
> platform devices for each capability so that they may be managed by their
> own driver. The PMT architecture is (for the most part) agnostic to the
> type of device it can collect from. Software can determine which devices
> support a PMT feature by searching through each device node entry in the
> sysfs class folder. It can additionally determine if a particular device
> supports a PMT feature by checking for a PMT class folder in the device
> folder.
> 
> This patch set provides support for the PMT framework, along with support
> for Telemetry on Tiger Lake.
> 
> Changes from V8:
>  	- Rebase on 5.10-rc1
> 	- Add missing changes in MFD patch from V7 that were accidentally
> 	  dropped in V8

Which changes are those?

Do I need to re-review?

> 	- Remove error message when unsupported capability found. Avoids
> 	  unnecessary noise on some systems.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
