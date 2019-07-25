Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD37598A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 23:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfGYV0c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jul 2019 17:26:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44320 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfGYV0b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2019 17:26:31 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so100244991iob.11
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2019 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=76/gf9wFjHpTUDE6FbprmTNUjZsTgezSyFFVzVXR7sk=;
        b=LvIZiJGza3pKmSCbWyc7TTTl2OoTMKpU2DU+CJ88atN9zvt70BjGxMhE8khQszS08R
         B+BkmOtok5QjBd0CNmzQovLkSqNeWy1nkAL78WV/5VjMe2EOJK4KrRcSZIyv+ft2yG36
         rGUchtH3UsuNM09rqm7G7TPk2NVZQbNkdWHOBTFgOjF8jtKYD8v6hbPDckPXiiEsK6Hy
         6UBP1VETBolc/9LXsDFQQxf9vf/AzCxn+dDyhrhXKbFl3RXq33BTBqLh4TfEBljdtB/h
         uL3TxzqhMjDhvk8EGTxoJk72XZRsFuUVEIE0yqs4HLmeDcBeOxrHg0OoI0taTq9UKfy5
         St1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=76/gf9wFjHpTUDE6FbprmTNUjZsTgezSyFFVzVXR7sk=;
        b=jH2WPMGw0trQapmgzBZK2+9W4DGElHfXsqsG/GiYN4ymVlwYhhgY7aXUkmMCJ5pWlj
         mhCzX1tkJ7Ewp7/QDPUjS8r6oejMNL5f5uLe42sokyZ0ZCUOysdr1+AMFSaseVtMbnJu
         Q7x5o+S8yLvJhyxPmLWW6bUxvUOt72sgFvzKQ52rXUZFM9XXZ0hk9zhGfu2QiTdEUyj4
         TZifbIvLMAhtzzmJ+BbBUpCn3uy+6MZ8cUZOkzIGBa+jzOXIZs+BaWuDkn0Ex3fUmury
         N/RbDdGfhvgRR/cNv+zAbWqM5thRM9mEVFSiO6dAvjPNy/2zBJVc72ciGizUOibDnPA0
         gjmQ==
X-Gm-Message-State: APjAAAUVOXIX/5w0wuR/5mRX0kJku4liSKUpON1tRCjY7oHcnJj0LvMc
        dcUhP2+KeYWC/7KkZsmzvkUm9A==
X-Google-Smtp-Source: APXvYqyhHmO1gUw1vzdQhPJd+YQtrM3wJpJ62sVmiyXexiirus39t9vFwVY26bMD21fVqSBlVx9y/Q==
X-Received: by 2002:a5d:83cd:: with SMTP id u13mr80672996ior.297.1564089991129;
        Thu, 25 Jul 2019 14:26:31 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id s10sm118939163iod.46.2019.07.25.14.26.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 14:26:30 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:26:30 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     bhelgaas@google.com
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] pci: Kconfig: select PCI_MSI_IRQ_DOMAIN by default on
 RISC-V
In-Reply-To: <alpine.DEB.2.21.9999.1907251422040.32766@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1907251426010.32766@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1907251422040.32766@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Jul 2019, Paul Walmsley wrote:

> This is part of adding support for RISC-V systems with PCIe host 
> controllers that support message-signaled interrupts.
> 
> Signed-off-by: Wesley Terpstra <wesley@sifive.com>
> [paul.walmsley@sifive.com: wrote patch description; split this
>  patch from the arch/riscv patch]
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>

This is missing Wes' From: line.  Will resend a fixed patch

- Paul
