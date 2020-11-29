Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0742C794B
	for <lists+linux-pci@lfdr.de>; Sun, 29 Nov 2020 14:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgK2NGu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Nov 2020 08:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2NGu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Nov 2020 08:06:50 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D1AC0613CF;
        Sun, 29 Nov 2020 05:06:09 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id pg6so5043622ejb.6;
        Sun, 29 Nov 2020 05:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OBNusARSTeLEehMn2hSY6WmWfYAsy9+6IC5LvcZopzc=;
        b=txiM1fETGKw0MZ1dmLODyhfeCQBWEq1MB0t97XDuMQpdyD9WrXNcgMpJWs6oxdiZWH
         nMjY18Kj9oad/j4zT5IO+QgTmrvlG3t08frQ0NsPHumUEy4NKWMJgtVoQTiCRAA8Du0A
         kbR88YOSApxsTLrzrr1EHpRNChRnK1DbsZB8ULsyz0ba33hhzqvbn9DQ6kXrB80cn6YQ
         tXRjRyoi/VK6BV8YDMe2vW6DQJC4ix5LOFSU6zIYeGxiW1WsILnHW48fjiDyMfSV2+ni
         UZ2i/XNG3vBaZQyyWucsnG+u11CxFS7d74xnjB/aFuvKJz95D5QWDSATFmsnilOSkGGp
         UbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OBNusARSTeLEehMn2hSY6WmWfYAsy9+6IC5LvcZopzc=;
        b=EZ6eMUwKjQodU1B9k1ecSAYamKnLtGALtTQRxKPxegccMiTRC0q04RxXT+Q4QfW9Ke
         pq8z1WcM3BhKbHevnNU+WlXWu5+ITyp6azBk5/71S3XcK/hObgzqXjpBiPXgXaCGdntQ
         4OnLgKy1sKN43k9sJLilkXz2Uex6f93KxJQ9N5OIP68clYD944XC4N/d4rwFj0CjQhHg
         6yrbRNQQUUasKHKODDcnrwcz1+nIBH+MuFmw2kY7VCufSit8Mo4AHTRaKTF7Ky6EsHYx
         EmsGYhZrswO5/bzBJ1DW96wTMv65+oqQWstrPfpzpwWeFZLQnjj8DP+jfh+wOqtsix+j
         qRhg==
X-Gm-Message-State: AOAM5332lgB8fii+g75Zbr95dwq/vtFcbq/boreyz/qeMsvHi7bzTq7+
        07fAk65VuGsI0YoBWbo75fAf3T5MvsE1mQ==
X-Google-Smtp-Source: ABdhPJxU9yksuV1C+LRDbd905yWQeWN71zpG6SFxcuKZ8wwZjVZe4Oc2R12cntDM074WGJ06Pv6mqA==
X-Received: by 2002:a17:906:52d9:: with SMTP id w25mr16086446ejn.504.1606655168026;
        Sun, 29 Nov 2020 05:06:08 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id n23sm1251104edv.12.2020.11.29.05.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 05:06:07 -0800 (PST)
Subject: Re: [PATCH] PCI: rcar: Add L1 link state fix into data abort hook
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20200912211853.15321-1-marek.vasut@gmail.com>
 <20200913172207.GA1194428@bjorn-Precision-5520>
 <20201119162508.GA23852@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <092d664e-098d-2f51-9d47-4a60a8bd9bb6@gmail.com>
Date:   Sun, 29 Nov 2020 14:02:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119162508.GA23852@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/20 5:25 PM, Lorenzo Pieralisi wrote:
[...]
>>> The R-Car PCIe controller is capable of handling L0s/L1 link states.
>>> While the controller can enter and exit L0s link state, and exit L1
>>> link state, without any additional action from the driver, to enter
>>> L1 link state, the driver must complete the link state transition by
>>> issuing additional commands to the controller.
>>
>> So IIUC an R-Car Root Port can't enter L1 without help from the
>> driver?  That *sounds* like a hardware defect, since ASPM is supposed
>> to be "hardware-autonomous" once configured.
> 
> Sorry for the late feedback, starting to queue patches for v5.11.

Same here.

> Is this issue ASPM related (ie is it supported by the host controller) ?
> 
> *Or* it is related to kernel driven device D-{1,2,3} L1 entry ?
> 
> I am asking because if it is only related to D-{1,2,3} device state
> entry we could intercept the PMCSR write and move the quirk in config
> space accessors.

I don't think you can always intercept the entry into L1 state (e.g. if 
userspace triggers it), but you should be able to recover from such a 
state (this controller does permit you to do so), so I would say this is 
a third option.
