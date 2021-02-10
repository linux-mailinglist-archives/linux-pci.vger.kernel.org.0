Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B8315B84
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 01:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhBJAor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 19:44:47 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:34267 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbhBJAmv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2021 19:42:51 -0500
Received: by mail-lf1-f53.google.com with SMTP id h26so338438lfm.1;
        Tue, 09 Feb 2021 16:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jp61220gRqoTuclVP4V0Wh3NhhyBFN50NZfTrAPVLqs=;
        b=Hc0dPG+9LTWbF0YGBGE4/OlJnYboaGl3ld1laqYjk6KpenSUnburhvLuEGnGP4oiuG
         eNOFclsy6V+2TNx8IrV77+hkIfeXaEd1z7S7F1ISsDGZ3YR2eswYR64DfyF8lMd9T9ea
         zfeR4j4uNi/+m6nrkwJwQ7DhUyXgzPu8RUOkmT9xLMUs7NdXWWYRydTYhQ/3tJT114Sr
         EmoUc+ev9RzVI/NXlupcYvFGiwkZJkfC9w9axprjg7gyoSgLH5zrwFvnCXpewhYaY/Gv
         pt7BPh8WBm+1VxTP42RlLybTIaWsHiwpGza2dzx512G2+B0WuB4lOZFuVaOPTyRRNwSQ
         q85g==
X-Gm-Message-State: AOAM5332T4tEQEQyB0hT6Iy8oIhfLC/EBLkS5SzuONfUdi+jnwTVkQJE
        gUrwxH9btrhyoheWNBwPSls=
X-Google-Smtp-Source: ABdhPJyvPoG6O/WBwAwI+e0nRQmtuM2HCCVaU3lMXPThSx9yJF3UYIYIi9IJ3S6MMNgdWs+BqKcPIg==
X-Received: by 2002:a05:6512:988:: with SMTP id w8mr302991lft.294.1612917729100;
        Tue, 09 Feb 2021 16:42:09 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x3sm53996ljj.120.2021.02.09.16.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 16:42:08 -0800 (PST)
Date:   Wed, 10 Feb 2021 01:42:07 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     srikanth.thokala@intel.com
Cc:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v7 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe
 controller
Message-ID: <YCMr3yCv5+cAjzDc@rocinante>
References: <20210124234702.21074-1-srikanth.thokala@intel.com>
 <20210124234702.21074-2-srikanth.thokala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210124234702.21074-2-srikanth.thokala@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Srikanth,

Thank you for working on this new driver!

[...]
> +title: Intel Keem Bay PCIe controller endpoint mode
[...]
> +title: Intel Keem Bay PCIe controller root complex mode
[...]

Not sure if worth spending on this, but I've noticed that people often
capitalise "Root Complex" and "Endpoint" when talking about PCIe controller
features - you did the same in the cover letter, so I wonder if you want
to keep this consistent.

Krzysztof
