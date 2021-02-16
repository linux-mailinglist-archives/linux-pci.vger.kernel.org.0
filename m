Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9B31C5B3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 04:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBPDB3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Feb 2021 22:01:29 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:41454 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBPDB3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Feb 2021 22:01:29 -0500
Received: by mail-lf1-f41.google.com with SMTP id d24so13605112lfs.8;
        Mon, 15 Feb 2021 19:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hAaExniY8eD12XfJrRZgauVsXLQgbU0LNTK/CxUaGD0=;
        b=p2H9nbhToYeTGyCkc0TVm11apr24pZc2N48go0T9gxTY5nogKNPDCCzCYcKm47R0/6
         bXbf8g3hvV8w0nAhLOOqxcH3UBuD07JwS4RYBYPEuwSo/zRGWRvDC4yMazdWul+ETbwB
         0NS3gubGy2z8+ohCJ8zOpSAGB/dGkopiiOg30shZILY3k2qYCm0vRfBFNY1GRp51QAn6
         lkZKgEa8XxyTsKqztR+wIYvoPVarUE3AudpOZ5MzSsOtwpbuZ4J0lwuJNiKJ53g2yOMD
         3SsmcPNYVv75qVjmSQjM0/tVtF+l0B9MdiFZmusUkmnI0+VDvkc8BBU2fHZMQW8kBwZg
         Gdtg==
X-Gm-Message-State: AOAM532U1YSWyeiFIpkEfdKYVuYU0+HmrUA5vewB5WQo9jgt11DJT/xE
        bDKJARC7a6TpMSNLAaLSs+k=
X-Google-Smtp-Source: ABdhPJyXp9qx04aRrwD4mwVsy804rjpKjNseqt4qi1Fxu41G4c0v+N3TEFwPYJvXgUUu/xHLZXv29A==
X-Received: by 2002:a19:8186:: with SMTP id c128mr10274693lfd.377.1613444446773;
        Mon, 15 Feb 2021 19:00:46 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u4sm2055765lfi.255.2021.02.15.19.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 19:00:46 -0800 (PST)
Date:   Tue, 16 Feb 2021 04:00:45 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Chen Lin <chen45464546@163.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, helgaas@kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Lin <chen.lin5@zte.com.cn>
Subject: Re: [PATCH] PCI: hotplug: Remove unused function pointer typedef
 acpiphp_callback
Message-ID: <YCs1Xetu4ifu0iGv@rocinante>
References: <1613443120-4279-1-git-send-email-chen45464546@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1613443120-4279-1-git-send-email-chen45464546@163.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Chen,

> Remove the 'acpiphp_callback' typedef as it is not used.
[...]

Good catch!

This typedef was initially added in 2005, and then it stopped being used
around the Kernel version 3.7 release, which is also when the sole user
of this typedef called acpiphp_for_each_slot() has also been retired.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
