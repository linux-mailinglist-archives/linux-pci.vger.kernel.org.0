Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC7230990D
	for <lists+linux-pci@lfdr.de>; Sun, 31 Jan 2021 00:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhA3X4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jan 2021 18:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbhA3XxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jan 2021 18:53:10 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E2FC061793
        for <linux-pci@vger.kernel.org>; Sat, 30 Jan 2021 15:51:51 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lw17so7955634pjb.0
        for <linux-pci@vger.kernel.org>; Sat, 30 Jan 2021 15:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/7bS81IVu1JlzOqn6sxVl7PF7QPT/qamlj9psA4nrKw=;
        b=KakMFpmDEnIJAfIkwgFElM2OuCuzZHKBG8btmmU1ofJKTS7yI0zo08pqWacZX46IFI
         8fHWvBqPYFSupOKNtk43JJoG/x0xDILY1ny7YHyzKcQI/6v2eq+1+2sACm7zDjm9calq
         rah5jhD/eOqyjJnmkmMSpcrIa4Z4fOuHgRuowyV0XL+mnCr1BmkOz7ivyntQVH2EneOx
         iLG09O3UCbp8bUAmiA7k7GMVemtVjmTBSyL1T7IkifZ+NF1tJQKusqD8Mpl9Ru7GJRTO
         kL4WwHN7MMbiJL5NcAZkYBPC8h4+0dg3MVcVYtNOrdGtaqM3E3ELgyet8WY0yHGgx+NL
         TDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/7bS81IVu1JlzOqn6sxVl7PF7QPT/qamlj9psA4nrKw=;
        b=pfLQ76ToJW3Eu29fzfv2T07aLdnlSDJnmFFGsmfZfxFfxlzWl0EQj1FA+EUy1BlqR6
         NybwB4iWxTdqKVQIly7dqztMv6zukOhlT+iyBaZ+O1lN8bj6Wg3m/1jVsP/9FVthRSYM
         BpjkgHknjhCqvs5C55FjSjggPY5u3ibyhqCCoNpm5f+RIsicXdXZPljId1rQC11gK5Rs
         Gv21QXuNDtxv9zMY0wQa49suNmoqR0EfUeIOLRmMXv3TjMMyw7xcy7zSt38E7L2btclT
         47qdYPvPDXo7tEstbst81mMfQxj15VyPe9JoagPvbFI8GXqqcwdlBkXDluqCwpKzcU6Y
         SEXg==
X-Gm-Message-State: AOAM533POg10/d1VTBKBky87R+6bogCuSOEW56UlfwsygLJB6khkdnMh
        tE4SQ+jC6rM/l/04mwIxAQ1bGVns79uhAQ==
X-Google-Smtp-Source: ABdhPJyWfU3F6QFSqgDGRamotw78d6vqTVIqlXrDVhMybwvQ7IKMWFaK63q32G3vVTVfyW5mjbPKKg==
X-Received: by 2002:a17:902:9b90:b029:e0:6c0:df4f with SMTP id y16-20020a1709029b90b02900e006c0df4fmr11725622plp.60.1612050711168;
        Sat, 30 Jan 2021 15:51:51 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id b62sm13308050pfg.58.2021.01.30.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:51:50 -0800 (PST)
Date:   Sat, 30 Jan 2021 15:51:49 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
In-Reply-To: <20210130002438.1872527-4-ben.widawsky@intel.com>
Message-ID: <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-4-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> +{
> +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> +
> +	cxlm->mbox.payload_size =
> +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> +
> +	/* 8.2.8.4.3 */
> +	if (cxlm->mbox.payload_size < 256) {
> +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> +			cxlm->mbox.payload_size);
> +		return -ENXIO;
> +	}

Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and 
return ENXIO if true?
