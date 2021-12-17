Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1416B4783AE
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 04:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhLQDfq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 22:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhLQDfp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 22:35:45 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894A9C061574;
        Thu, 16 Dec 2021 19:35:45 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f125so925637pgc.0;
        Thu, 16 Dec 2021 19:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cFaKdICxmfUw02RflO0Dmrltq2VZaLT3Eto4pimP01E=;
        b=oY+G4Pn4MmBw8nQpM7zUpT3Ksfb9nKli6cXU0kt4ks3dW2JK0i5WyQHzg5KsMpk9kl
         BzBExXMR+Kcxx/hj4Ph5n94n1ZOK+3q0IQ9ic4s6LOI+DVJonUd7BSKLqn6iMY/FX9vI
         E4GDT6uSJXhbaWEDsS12T88ODMjKgPKX68mgptv4fotdPsPNcg0s3s+R6uQ/xa3eDyEA
         azVxdaedLcD6owK6bNMkpXAbHPxqU7efvCz047IuyI0e2rV8fPSIurHn+5HnapLP3w7R
         4NW8CyuyO9NNsotshZnOvM7B8uvuwb9SGuOu8wQj3GMYwnkOFxIwStna7Q3og6zTqaPd
         oLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cFaKdICxmfUw02RflO0Dmrltq2VZaLT3Eto4pimP01E=;
        b=kFlTxCBEbg8I5FMwOTUNPc5qaGUxti/CFhT6Tfb1qhso6C+JGrdGNawmj5cV8jumHP
         dUdGF3lefCFhoUo9fy/UftMTlYaatfmQZGkZYcet7XyQ3pOJLEydubBGvjwpM8lrTnHm
         04x8OmBbNJ9wnMZBOl4FVinPKmsk6EMEMslm/8Xdjl/7B7GdYw1LevfdWcIASvam+xKH
         dhYbSYKlhCJgLqJRhN3i5+QlKD6BS8JjU0D99XN6LctO5EoK5m19jGGYAINmyLTWQgxd
         IsqA3g9HuIREf1cPOB9FYtZWVruSAF6m71IWmpiVrsOlsO7vVISXZWKMvc09Z+AnxvbR
         bqtQ==
X-Gm-Message-State: AOAM5310Cx4kAMbg9u+9K/YA1Gmp406UkQt0NFSZFTN5H66cvZgW5GOX
        ot7G8ebxZqwK+mGfjP7D+rU=
X-Google-Smtp-Source: ABdhPJySMPeEYlgUrdaQVO0gCGpk8QMkK3evy3O8fdvns1knXEpQ141qrz6yml6rPUfWJhjj4euOQQ==
X-Received: by 2002:a63:f157:: with SMTP id o23mr1195151pgk.185.1639712144682;
        Thu, 16 Dec 2021 19:35:44 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id 130sm7223790pfu.13.2021.12.16.19.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 19:35:44 -0800 (PST)
Message-ID: <eb1bbbc2-a3f1-86dd-721f-f4bbf284210e@gmail.com>
Date:   Thu, 16 Dec 2021 19:35:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v6 0/6] Convert iProc PCIe binding to YAML
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211214035820.2984289-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211214035820.2984289-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/13/2021 7:58 PM, Florian Fainelli wrote:
> This patch series converts the iProc PCIe binding to YAML. Given there
> is a majority of DTS changes, it would make sense for me to pull this
> via the Broadcom ARM SoC git tree.
> 
> Thanks!

Applied 1 through 4 to devicetree/next, thanks for picking the remaining 
ones Rob.
-- 
Florian
