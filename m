Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34DA1F023C
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 23:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgFEVmJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 17:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgFEVmB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2020 17:42:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4051C08C5C4;
        Fri,  5 Jun 2020 14:42:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u13so9675884wml.1;
        Fri, 05 Jun 2020 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UdH/nxi/Mb+fPq3ivMKnio5NEFoRZDU+dnCa779cs8Y=;
        b=RviLL0UINg3jkOxwq2cq1ILmV2hNHNPulQTObBCk5eUSy4EowbVzT1Dnm0ULW+l50r
         ws5ltl+P7nSUcdTtGs6dQA/1AFZoxyErSxIz9NEtQY4XupgQrp7SI/BlfP61EnpRQ0nf
         sfPkOHbLtu/JiFUNXRbV6wlVDjy/YCqyqKveLt1jECajPZ45o1pxdgodShqAAhDJVjLR
         9TAuvdqzCM3393zRQDTWEaZ8xZkyi8C37V+QGg6E8zBTfV+fpbpBIOrz+lxUdKryjIgx
         JXdqvcBijPIDXuW38GaX6gq/ZBKwS9yfzw+IhSGPB5yv1v0ZQ9KFAzheQh7oPa5TE6FP
         hYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UdH/nxi/Mb+fPq3ivMKnio5NEFoRZDU+dnCa779cs8Y=;
        b=aGXFllGKoINY9bp9GVeh2zUWaaW71rKk0HTNHsQXSVwvuGxvb3aYMJiWOZITCJhgaS
         JSFVUXfQafa6fiVmQcaFLM7KsXiklhRV2bD3RiCJgkR+LoFzBDy+xJHqTOFQK39Qi1Gc
         UROPM6pFVsgrw39EVoPV+lT+GzjiuF4L5Br72byNNzENSdqlNaU2XxqrDZM1n5OrWTP2
         Aqlb/wSjkkV+oPI0htbRIs70IeGSvfIIJbWdtBB6DBGQtgyWUXB3UwEGtHpO0WsqueYT
         20n7W5uorubzPffOfO4NNVmCf9Mmf9GrEnZtKWtYQFs5U364H+igEyOvrV+H4I5aOf6F
         O7TQ==
X-Gm-Message-State: AOAM531iw6NuK/tbVStzzTpoS5zEAZBRu8Y4/jdoluCYJJ1GjepduEku
        FJQ8Ydla6V1HAHoD1YUJtos94YhH
X-Google-Smtp-Source: ABdhPJwZAB8sYp0qQRP3K7v5LcMrPrJKP4i5Otr+cK7ECVE4aprBSt1yIizfQYfZZAw/QFRrX56kLQ==
X-Received: by 2002:a1c:7e52:: with SMTP id z79mr4733418wmc.104.1591393318899;
        Fri, 05 Jun 2020 14:41:58 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l17sm11998448wmi.3.2020.06.05.14.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 14:41:58 -0700 (PDT)
Subject: Re: [PATCH v4 05/12] PCI: brcmstb: Add suspend and resume pm_ops
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200605212706.7361-1-james.quinlan@broadcom.com>
 <20200605212706.7361-6-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5014b30f-a1bf-66ab-0626-8816a3cde5ff@gmail.com>
Date:   Fri, 5 Jun 2020 14:41:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605212706.7361-6-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/5/2020 2:26 PM, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Broadcom Set-top (BrcmSTB) boards typically support S2, S3, and S5 suspend
> and resume.  Now the PCIe driver may do so as well.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
