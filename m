Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6900E28BF1B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbgJLRjV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 13:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404054AbgJLRjV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 13:39:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C68C0613D0
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 10:39:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 10so4634439pfp.5
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3qybxW+JYDZmWfsQqamw5jDX4v50ggiGc8P7eJmMuY=;
        b=HkKUpC4Lw71PeZFuAnPrTsUFzWXrM1FpXaN0GJcY12DF0dI4/RvEbAx5Kf4siNMfRE
         t+9NjUuWv1DvSLo7gs/u6LWZ3dY+Te/gGdWvlMIfyYZd09LTlypGwc5AohlPux/ZxBRZ
         N3wJ8NgLf9PSYDxQJuOGsTtqpnDxv9sHwuRbOqhvtXZEXKcl5Zqn/wjt/GVUvDUZtWyE
         Ib4vBOb62uyckFWOSTM/ahhE0OKov3xfxkb4Ia1DADFmFGM0IqVgsBhzOCHXcOKRn/D2
         7D1jzw98RICUrT0pX1D28TQiv29t6Url+diZy52QpPUxLLcIDOu9xEvGwBF5DqSuR1ON
         A/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3qybxW+JYDZmWfsQqamw5jDX4v50ggiGc8P7eJmMuY=;
        b=eakOjpdDEZJZCjca1VAyocFkwaRS20BGPN2qaWoqsiJiM4uUxGhUwvojqEk4mblnG2
         4A79tbhRELheeT6yws5U3YJjlgP7nRj1bICRgUcsu/1Zkv+MnkM8cBvqn4JV7kPthhCH
         oyEzk5M0NczfifstFbwhZognNFh+bSsDJ+0W/0gb/qTr+aRLKR0VtSRZwglrR699JrrP
         wpgaBy1NgeVrfNXnIombtlrQgkQy72dM15H6zfnnmbVmNl52M94gT50Bv5bNZPuvWsDy
         +YAOh7ZKkpkz4Im+BGdREMjTv9wkPqVOkFGQbX8ESzl1VsNPMmJq36X7IAYSqonvrY6K
         LfmQ==
X-Gm-Message-State: AOAM530gJpvJ9DXCX2WiDisDJEnimzhiGQUib4pLrcYzrxePQ13IXNCW
        u59InbcL7vij5t0/mCmw1RD51PBu08ehJg==
X-Google-Smtp-Source: ABdhPJy0pBpeA/GhQHLOUvcHk7hEtkCGvHBFsigoA8BKdFDF5/yJRpTmpn/Uoq7Q4XOjk//MMJrurw==
X-Received: by 2002:a62:503:0:b029:13e:d13d:a0f9 with SMTP id 3-20020a6205030000b029013ed13da0f9mr24563407pff.21.1602524360338;
        Mon, 12 Oct 2020 10:39:20 -0700 (PDT)
Received: from [10.212.84.128] ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id g22sm20782555pfh.147.2020.10.12.10.39.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2020 10:39:19 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Chris Friesen" <chris.friesen@windriver.com>,
        linux-pci@vger.kernel.org, "Christoph Hellwig" <hch@lst.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Nitesh Narayan Lal" <nitesh@redhat.com>
Subject: Re: PCI, isolcpus, and irq affinity
Date:   Mon, 12 Oct 2020 10:39:16 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <3FF15DD8-72AF-4C1D-BF66-248FC87FD903@intel.com>
In-Reply-To: <20201012165839.GA3732859@bjorn-Precision-5520>
References: <20201012165839.GA3732859@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12 Oct 2020, at 9:58, Bjorn Helgaas wrote:

> [+cc Christoph, Thomas, Nitesh]
>
> On Mon, Oct 12, 2020 at 09:49:37AM -0600, Chris Friesen wrote:
>> I've got a linux system running the RT kernel with threaded irqs.  
>> On
>> startup we affine the various irq threads to the housekeeping CPUs, 
>> but I
>> recently hit a scenario where after some days of uptime we ended up 
>> with a
>> number of NVME irq threads affined to application cores instead (not 
>> good
>> when we're trying to run low-latency applications).
>
> pci_alloc_irq_vectors_affinity() basically just passes affinity
> information through to kernel/irq/affinity.c, and the PCI core doesn't
> change affinity after that.
>
>> Looking at the code, it appears that the NVME driver can in some 
>> scenarios
>> end up calling pci_alloc_irq_vectors_affinity() after initial system
>> startup, which seems to determine CPU affinity without any regard for 
>> things
>> like "isolcpus" or "cset shield".
>>
>> There seem to be other reports of similar issues:
>>
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1831566
>>
>> It looks like some SCSI drivers and virtio_pci_common.c will also 
>> call
>> pci_alloc_irq_vectors_affinity(), though I'm not sure if they would 
>> ever do
>> it after system startup.
>>
>> How does it make sense for the PCI subsystem to affine interrupts to 
>> CPUs
>> which have explicitly been designated as "isolated"?
>
> This recent thread may be useful:
>
>   https://lore.kernel.org/linux-pci/20200928183529.471328-1-nitesh@redhat.com/
>
> It contains a patch to "Limit pci_alloc_irq_vectors() to housekeeping
> CPUs".  I'm not sure that patch summary is 100% accurate because IIUC
> that particular patch only reduces the *number* of vectors allocated
> and does not actually *limit* them to housekeeping CPUs.
>
> Bjorn


Chris,

Are you attempting a tick-less run?  I’ve seen the NO_HZ_FULL (full 
dynticks) feature behave somewhat inconsistently when PREEMPT_RT is 
enabled.  The timer ticks suppression feature can at times appear to be 
not functioning. I’m curious about how you are attempting to isolate 
the cores.

Thanks,

Sean


