Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F32FE0713
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfJVPKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 11:10:54 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:42392 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732181AbfJVPKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Oct 2019 11:10:52 -0400
Received: by mail-pf1-f176.google.com with SMTP id q12so10828664pff.9
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2019 08:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8AwEM/obC8LRWaCg0EJY39OUdBAOiIs+mtoo3/7ay7o=;
        b=TY/O5sgfbP83gCIJYbSOwp2pSlXitJ52LK2TSFB7tfZHpYh1N/jc6uQPgKUW1cfaO9
         JhmXA6LAR9HtTJjJTD4RGVzcD+Hqmd0iLE5KNn8NmZakqyzU5QhzevM+0Is41C6D/afR
         Cqzs33Fca2LEAueSK4bCnTDIsNbWyA1zB0iXlz1oHoG5MNdedOA/oMeJKvudZYYcQseE
         FqYUA6CUS/V887/Btn7StQ1ED2pKApjfpRV8PHqsibaIaWMy0VjUr8kmXlh8QAE+z7MN
         wEExywby+9ypE2NuoEJgrkHG183v6Kl0MfR7FMLQI/u1sI+7tW07ATsd1kouqokhzgdA
         TCig==
X-Gm-Message-State: APjAAAVVmtpnnEd6Im/ImoZDHbrSH4M+tcuQBL1bKW3lJ5RtSjDugtqT
        DFpYUJS2CrDKmEtE5+N0bsIr64eAOGk=
X-Google-Smtp-Source: APXvYqwpcdig5U0KlygiWr/07ufZuXhgsDfX0+P8KVKTiRMi0+u8a5sKyE5qZZmPdgiu+6Nh3jLGkg==
X-Received: by 2002:aa7:9156:: with SMTP id 22mr4907293pfi.246.1571757049387;
        Tue, 22 Oct 2019 08:10:49 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t12sm15557832pjq.18.2019.10.22.08.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 08:10:48 -0700 (PDT)
Date:   Tue, 22 Oct 2019 08:10:48 -0700 (PDT)
X-Google-Original-Date: Tue, 22 Oct 2019 08:10:42 PDT (-0700)
Subject:     Re: PCI/MSI: Remove the PCI_MSI_IRQ_DOMAIN architecture whitelist
In-Reply-To: <995f625b-1f56-6d97-ba99-9a4298e9dd37@xilinx.com>
CC:     Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com,
        helgaas@kernel.org, tony.luck@intel.com, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, pbonzini@redhat.com,
        firoz.khan@linaro.org, yamada.masahiro@socionext.com,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     michal.simek@xilinx.com
Message-ID: <mhng-d42f23ae-e51f-49cd-9533-a4c793cd70fe@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Oct 2019 23:20:09 PDT (-0700), michal.simek@xilinx.com wrote:
> Hi,
>
> On 17. 10. 19 20:19, Palmer Dabbelt wrote:
>> This came up in the context of the microblaze port, where a patch was
>> recently posted to extend the whitelist.
>
> I hoped you were aware about this discussion we have with Christoph.
> https://lkml.org/lkml/2019/10/8/682
>
> It means 1/3 and 2/3 should be replaced by mandatory-y and I expect
> msi.h can be removed from architecture Kbuild too.

I'd missed it, but that seems like a better way to do it.  I'm going to assume 
you guys are going to handle this, so feel free to drop my patch set.

Thanks!
