Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0646DD80D1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 22:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbfJOUOU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 16:14:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53310 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfJOUOT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 16:14:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so406213wmd.3;
        Tue, 15 Oct 2019 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2PqkplBf6NPIJ3WMj/EFZvUWChhaNZGEC/iL4ajfRno=;
        b=CKREPJMXIFPF4bdVthphuXZaVVA8KVzKtRFegpSRU4aaZ5VkUdavQpOMebkD3ZQJCf
         N1pQzGuM1Sm+OB1VGI+7FYTUTPcy4w1kPmaTvCXU1xpKDzXFSk/DG4G46+6k7muUxT4g
         EZ4IqANYNXBWhTzJ3XGBciaxvsRqDrl2ilY8Rhd3yUgcA/6rAvAOUs2dPYdYRUpVQlpd
         aMLV6//uU2JMGDzYopafCedYhWkmJFFokVRguk5AONMXuu3E61HXE0gCj8byrJeH3jqi
         jY/bqJlxm5tv/AXS3L8fPy9HmpMRTc6wFLjsscOTDuKHyTmB8O1DImuYXVwoOKEyxHhF
         A3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2PqkplBf6NPIJ3WMj/EFZvUWChhaNZGEC/iL4ajfRno=;
        b=JBhsw7EnWbdAZ3Y3Ql5DhV5gnbLxBepqa1iOLx1vIZPG0wfRmGBk9bPU9l+uRRA/E7
         6qcN8cxC6N2+h/mKXufhhDHmH5Y8V3gtLsylEGzpmZVAnO7sx49huZ6IwU+3K8eMVQhU
         rKi/zaFCbC23MUyUZhtuxDg02GPyKRtCWPcmgKQGn8wwvREDqxECBULUS5fZwqJBYy64
         MwytUCyMOiv6GSnON9jp8R58yyvRgkSDWvK8eQ7oU2ERWICkNCHon2D/LNezjBUOQNtq
         6GTD+Zolf8fqyFLFnA8EqufBxPPT3BHokrP8/AQBfOGvfJmKbrBOjN1wtluByzNaRK9t
         EAXQ==
X-Gm-Message-State: APjAAAUaqgyPWw2G3V9aFMsrcb51azC/eYC6SSHOZQY49+auoGwqVIhx
        4KrrJxmIeE9EDiPeLz5jEVY=
X-Google-Smtp-Source: APXvYqy4M7y9wIbN8k7lFLn97anPmLxFc7zjjSNq7mEHWENBsPAq1KqWTasQFGr+5YAl+zCb0vLdTA==
X-Received: by 2002:a05:600c:2c2:: with SMTP id 2mr209856wmn.112.1571170457383;
        Tue, 15 Oct 2019 13:14:17 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id r18sm273728wme.48.2019.10.15.13.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 13:14:16 -0700 (PDT)
Subject: Re: [PATCH V3 1/3] PCI: rcar: Move the inbound index check
From:   Marek Vasut <marek.vasut@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
Message-ID: <7bbb35d1-d628-597d-7a96-4f3629e5ac8e@gmail.com>
Date:   Tue, 15 Oct 2019 22:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190809175741.7066-1-marek.vasut@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/9/19 7:57 PM, Marek Vasut wrote:
> Since the $idx variable value is stored across multiple calls to
> rcar_pcie_inbound_ranges() function, and the $idx value is used to
> index registers which are written, subsequent calls might cause
> the $idx value to be high enough to trigger writes into nonexistent
> registers.
> 
> Fix this by moving the $idx value check to the beginning of the loop.

Is there any reason why none of these patches got applied yet ?

[...]

-- 
Best regards,
Marek Vasut
