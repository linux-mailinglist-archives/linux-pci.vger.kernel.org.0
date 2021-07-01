Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24AB3B939F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhGAPCK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 11:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232463AbhGAPCK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 11:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625151579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IVh85kthu0SpW7UY6smgM11I1yNN5lgiNNeNgndC7x4=;
        b=FnbVaaEUtTxLffeLXdycmyQ0IMLiUFqROzWEVmzdb8ZThmSsN05G/3SIStX9pBi4kQx5FE
        HbXlB6U82rD/wnlpmqZ5yzou7K232drvaT0gGQP4M9R1avcz5nskClvW9UVWRDSQPTxbWp
        m9ZWft0A+JLRUQBHPqB7wD1YGwsk5G4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-jnNuu0Q9Nb-I36NBkp-WzQ-1; Thu, 01 Jul 2021 10:59:38 -0400
X-MC-Unique: jnNuu0Q9Nb-I36NBkp-WzQ-1
Received: by mail-wr1-f71.google.com with SMTP id p6-20020a5d45860000b02901258b6ae8a5so2677708wrq.15
        for <linux-pci@vger.kernel.org>; Thu, 01 Jul 2021 07:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IVh85kthu0SpW7UY6smgM11I1yNN5lgiNNeNgndC7x4=;
        b=Dz06RFA5GbuZA9M4drIQusXFPMX4fOtHNWiQ5MHm6ARCsuFNH1266LTI8tD62MbdP7
         sdfOxqmw2DsxVZC3v4QLjbqQlBJDq4ZMjR8hLWe0SNmt61uHIFg1hVAEtZjFzuodu0UT
         GAoAKaSyM/xX7IjlvfTO9K2d6WOafTJRQPUDbd+/zqtZUvVPbN4hU98uFWXdUfi6tadN
         3yF4F7ZFcTukApzOUtB8gdmjvdghJRMTX7e9Sq8naXc5HShNl3Erz0lxFJOVzatVZzMd
         JobTC87npj4XJSahh87MtqBdKiLOwNZYNnHL3beGT+k+Hrm/NX6X25CtKy4QFwQD/DQW
         Bbtg==
X-Gm-Message-State: AOAM530O4V6BqBpgDH2J9cLbpfFDsmlYiJnhh3ebdSbIgz7qZoepwpH0
        tM4f7N5Nu2ctYSdwSjB7FpS1mKL6qsE/qCEHc4tBCchvaCIqoQUCaWJPmCtvryRwT/MW3jDNSNu
        cTF+WSB2smYNG9Fwf8LhE
X-Received: by 2002:a7b:c39a:: with SMTP id s26mr123453wmj.115.1625151577069;
        Thu, 01 Jul 2021 07:59:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeHU3WCUYY7UnaCN/G0uYLtwdgKJ2wXf9QG99tZjlIEUdpQJOc/y9rZPsTlaSCWiCikljylg==
X-Received: by 2002:a7b:c39a:: with SMTP id s26mr123429wmj.115.1625151576888;
        Thu, 01 Jul 2021 07:59:36 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id n19sm277863wms.4.2021.07.01.07.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 07:59:36 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20210701135949.GA51123@bjorn-Precision-5520>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <747df123-0aa0-7cb7-9fb3-f13c849894e5@redhat.com>
Date:   Thu, 1 Jul 2021 16:59:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701135949.GA51123@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/1/21 3:59 PM, Bjorn Helgaas wrote:

[snip]

>> The IRQ handler is not called when unregistered, but it is called
>> when another handler for the shared IRQ is unregistered. In this
>> particular driver, both a "pcie-sys" and "pcie-client" handlers are
>> registered, then an error leads to "pcie-sys" being unregistered and
>> the handler for "pcie-client" being called.
> 
> Is this really true?  I think that would mean CONFIG_DEBUG_SHIRQ would
> not find this kind of bug unless we actually registered two or more
> handlers for the shared IRQ, but it's still a bug even only one
> handler is registered.
> 
> Looking at __free_irq() [1], my impression is that "action" is what
> we're removing and action->handler() is the IRQ handler we call when
> CONFIG_DEBUG_SHIRQ, so it doesn't look like it's calling the remaining
> handlers after removing one of them.
> 

Oh, you are completely right. I wrongly assumed that it was for the other
registered IRQ handlers but reading the source is clearly how you say it.

I now wonder why when debugging this I saw that the "pcie-client" handler
was called when "pcie-sys" was unregistered...

But anyways, you are correct and I'm OK with the text you shared.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

