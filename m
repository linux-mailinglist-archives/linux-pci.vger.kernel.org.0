Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C160190063
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfHPK74 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 06:59:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36003 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHPK74 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 06:59:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so3727685wme.1;
        Fri, 16 Aug 2019 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wNVxrpOjRdGMbKUHWPQDveZoPp5EAe+1eRAUxJN9hEk=;
        b=vZkVmKoBKzHuPi4XcJItsJsLFT49svIQH9FcG5rLBKTteoJMkJJtkHXPcOhINNkhDQ
         Lqu9+DPd+QCnULTzpmlB5xaNsPq7mtEfDfp7dWAUrnbi46HMbi/hCRAXhTi6gKO+j9me
         3nAQXLE7TfrzqY6ZMmra2G27kRCUrdj34Mt8vaUlUHrWu0KLRdTbTnBpR2hYUAbsuC+o
         JaJPKpBfRKxfsj7SfYZcmpk2VBOjd1XIOsBzbDlxSH8yATnMQFNJ4e9h7bffq1DBY5uQ
         e4RNF7+DDlr8cDzgz2Rib8nrE9skoO3UiLRLlfL9Q6whq+hon4AsCxqs9I0S8bI2PpdF
         lu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wNVxrpOjRdGMbKUHWPQDveZoPp5EAe+1eRAUxJN9hEk=;
        b=ju7MeWnXtbS4JOwroPutHR7LZ4cZKPFVQ2CLEht/9p9BFdPfF8HNAr+4C3nU4iSgcc
         vjWhlX7b8sGfY8rqhjzzyTdwGqVLcci2Pr50oHzIjTszZlot+b5grG0MXte1qKXlScvC
         FhdHXxjGrRlvPcC5kRwrbup4TUODRvyz1PjHpdrX7P5C1BWO//wl2HZCk9a2vgcs7k//
         61LFJhtsQ6mHgrPhxxYFCsLVq+TzwfJO06N4p6TNkel/IkwraPxMAvAfL+G2xyvrDAkT
         qelfNV0GwQUgVkiTVvlpFHGHX3KBrP7CKgPVGn9zD1kgY+TAXIBhU/AUJfV0Gqw7vL3f
         UwUw==
X-Gm-Message-State: APjAAAV1qf3+j6XG1DGqAD6dCarC6mT8Yf5rJA9tBScAn3UARDEMvsLZ
        BJhAWRAW3bl0+XWPGI5MpdpobYxHKfY=
X-Google-Smtp-Source: APXvYqw0hTdsiWoBfuZx0niUdChJgAbSA0XbpGnoIjKzorYO0Fz9sv2KzliAqzZFWdcAx+GFNk9xGg==
X-Received: by 2002:a1c:c5c2:: with SMTP id v185mr7218010wmf.161.1565953193785;
        Fri, 16 Aug 2019 03:59:53 -0700 (PDT)
Received: from [192.168.42.64] (p578adb1c.dip0.t-ipconnect.de. [87.138.219.28])
        by smtp.gmail.com with ESMTPSA id p7sm3676908wmh.38.2019.08.16.03.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 03:59:53 -0700 (PDT)
Subject: Re: [PATCH V3 1/3] PCI: rcar: Move the inbound index check
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190816105227.GB23677@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <fcf457c1-7297-6a27-5bd7-4fdd05d72698@gmail.com>
Date:   Fri, 16 Aug 2019 12:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816105227.GB23677@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/16/19 12:52 PM, Lorenzo Pieralisi wrote:
> On Fri, Aug 09, 2019 at 07:57:39PM +0200, marek.vasut@gmail.com wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> Since the $idx variable value is stored across multiple calls to
>> rcar_pcie_inbound_ranges() function, and the $idx value is used to
>> index registers which are written, subsequent calls might cause
>> the $idx value to be high enough to trigger writes into nonexistent
>> registers.
> 
> Can this really happen ? 'index' is initialized to 0 in
> rcar_pci_parse_map_dma_ranges() and, through rcar_pcie_inbound_ranges()
> return value, it bails out on idx overrun, we can argue this patch
> improves robustness but I do not think it is fixing anything.

We probably don't want to write into non-existent registers ?
I think it can happen when there are too many ranges in DT.
