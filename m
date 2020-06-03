Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CFA1ED724
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 22:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgFCUCF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 16:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCUCF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 16:02:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05199C08C5C0;
        Wed,  3 Jun 2020 13:02:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so2275217pfd.6;
        Wed, 03 Jun 2020 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tnu/CyDw1h7BIsRr4D3oJlUTeZPgHQX82cMlMteGwro=;
        b=MEtVuioVQqydKcyY1av8VW+zNuuMhBV2H36aKCIaBdCfvbzyqA3UjmGvumOy4Nj6tg
         C/I6P72J8m/HjG1pkXC5IM9EgjFLssjUqSGVVxX2+97W8EGwM99MFl322eU0vVomTsO5
         R5oliaX5ikWGbU/a3LUYLVq0/tJpl0nqcJoze+M65G1ZMB2FRsX00IQUzVddl/t/TkV5
         cpAjpdmcmRVxvSEbIi4Cly/qIsReJw73HCSgV88hMbvGovIjKbpklalBh4u3k0T+NeNk
         LnfFjd3uX9AZaoAPrUmrkHLHhxWeSID2c1y0cnyLwWgsRJYZY7PGWRbOjqtAr+Mz9x6z
         JeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tnu/CyDw1h7BIsRr4D3oJlUTeZPgHQX82cMlMteGwro=;
        b=DobK8iuJVNNFVv2X7HSphgg8Umlr5vGsNlOAv4zWYlwdM2TGBYXmzMdarmgBkZnsdt
         Xy1ImzSDqJ2RdxEmzrqpcF/oqVgqSXEK8kJcw4vMrrtVJl4J1WCs28r4ku9jPyE9KiyQ
         +dZnq5tztnRc8H9d6cUdm7fkgLOPHiF3chxO8XRkklzwY9uv3SnCJVsbpobc6b6GDQ7I
         KxigOQbVuOUkP/jI9r44r2k57nZn3SvKNx0MUvjelaIszCYgpFjV55MSLDz6216qWCXQ
         JtC+9Z2L6EKLwSTbSvYn7ufMle8yUnLl4A4nmfATYzs0UtnLRMHCEWTydt11dzaSU4QP
         YeCA==
X-Gm-Message-State: AOAM530YTfgtK81IlKJOCZT/Xa5ayX40rIa1PVKmNIvCGcPn1xOOVhJA
        DlItzw3o8XaC4YBSqqFPtcweRNb5
X-Google-Smtp-Source: ABdhPJwD3HI/ELCFQ0lrxbRHrN080D1603C+j21RJiOcQinFRr3pKAOQdhIwn3FU/yre/Y8DZ/hcBw==
X-Received: by 2002:a63:648:: with SMTP id 69mr1003980pgg.109.1591214522816;
        Wed, 03 Jun 2020 13:02:02 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t22sm3340139pjy.32.2020.06.03.13.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 13:02:01 -0700 (PDT)
Subject: Re: [PATCH v3 13/13] PCI: brcmstb: Add bcm7211, bcm7216, bcm7445,
 bcm7278 to match list
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
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
 <20200603192058.35296-14-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5858bfe4-5c2a-1a12-e934-37e11c3bb693@gmail.com>
Date:   Wed, 3 Jun 2020 13:02:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603192058.35296-14-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/3/2020 12:20 PM, Jim Quinlan wrote:
> Now that the support is in place with previous commits, we add several
> chips that use the BrcmSTB driver.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
