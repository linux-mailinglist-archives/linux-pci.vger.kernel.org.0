Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A962B2946
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 00:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKMXkM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 18:40:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgKMXkM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 18:40:12 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605310810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eV1maNi6vuGWhMNE13VARkM72eq295CJo6jJCk4UikM=;
        b=kCv0ezlJIzNFkY80MPj+DrD+sB2GSaqpvpOpo3Qd7FEjJJ3stu9HGrjahGb5qzIE0h03Qn
        iS3AvDg13mQNgctLX2MnuY8QIdfj+BCL9pAxf1EmuX16S6OJ9BLqiYnMh4RLmLct24ZHsQ
        QG9ApUt/6q75848TCgS0Hle14hA2o7LhyAvEyoRW6jqVkStWa4quLj5oQlYQWeXSs7ofJa
        yLi5xcp0NVZg/YQOcUMBhwdwLqUU/kDzzsjmga8tHoMgwe1LEX4wDC4BTimeGAsMdPaOb4
        CgbWm+rE5ajbumm9iBWYVf93LpSR94p/IWA/XjV8biVp/xO/X9DQrQSrmenB1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605310810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eV1maNi6vuGWhMNE13VARkM72eq295CJo6jJCk4UikM=;
        b=TNqY+jtvCWIkSpk+1qI+9rFlsVm6anlCNRixUaxIDKTrlNdl0Z5Z7JnbJxlI86vPTXbw9V
        joxm4GO3bLoFETCQ==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, andi@firstfloor.org,
        lukas@wunner.de, okaya@kernel.org, kernelfans@gmail.com,
        ddstreet@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net,
        shan.gavin@linux.alibaba.com,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <87ft5cltqa.fsf@nanos.tec.linutronix.de>
References: <20201113164638.GA1019448@bjorn-Precision-5520> <87ft5cltqa.fsf@nanos.tec.linutronix.de>
Date:   Sat, 14 Nov 2020 00:40:10 +0100
Message-ID: <87d00gltb9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

On Sat, Nov 14 2020 at 00:31, Thomas Gleixner wrote:
> On Fri, Nov 13 2020 at 10:46, Bjorn Helgaas wrote:
>> pci_device_shutdown() still clears the Bus Master Enable bit if we're
>> doing a kexec and the device is in D0-D3hot, which should also disable
>> MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
>> device causing the storm was in PCI_UNKNOWN state?
>
> That's indeed a really good question.

So we do that on kexec, but is that true when starting a kdump kernel
from a kernel crash? I doubt it.

Thanks,

        tglx

