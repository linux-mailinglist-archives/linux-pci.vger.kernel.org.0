Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781B91ED767
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 22:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgFCUaa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 16:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgFCUaa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 16:30:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD47EC08C5C0;
        Wed,  3 Jun 2020 13:30:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so3780269wrp.2;
        Wed, 03 Jun 2020 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OfhBlq1v+qBxhvVpDjvVW2/p+pV1658RV/tkt05OUD4=;
        b=HDZKDpFmdo+9kjJsJ7tboIsHHjJLzQj15Uv4VHwgBEVZknxoQsdmeWOdbKZYgFMn9g
         xrbtGCxgupVx9/HdPdZ0+aFoGMiK+a1P4ivg8BHQG6UKZZLaC63OO53lK1Qk8ypZDL+d
         uWGmAS4+StxMlUWTz20jCGZxqbhsB6pkenXTSqydA3oIgLmuvC7szDMGzRnqUSUGxMPx
         1iK6wQmqBPHQGYkKir6MKP6EAXtuhj6+yAkTiytGuCUmvFFvE6u8Vpf/Ru/kdKK67Mg8
         8wbHf/ucK7lKVOu23qGrm0aaGN9bAsuBgaCPmnQLeFcHGzyXfKy8L68gyWsjYT26udNn
         qSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OfhBlq1v+qBxhvVpDjvVW2/p+pV1658RV/tkt05OUD4=;
        b=qT9HPfXp4SwYPwcq/AoF7FXRs5ufRqe1BwqRTFM8qmWTuqUREjP7spIoGx++PScX1J
         UEAN0AHjDnTOwJZrr2XGwPMh64B2PoqY+4xlQS5f4qDGpsSHnBu0DKbLh71WRuX89S6M
         Z96u2KTg8WH1CvmNuIrV66wHQgCSRTIk8M7LburjEDeS4XtEmSZ35Y5sy91IRnSu6job
         Z4P7+uhifBBzallUsRfQ9B3GMLKjrMJaxnKSXKQwdyxVkpkImXq3piHxaP8TuQQDQDkN
         MFz+cQ6ooH2nJfG1JcsVylJMfApWUfJ2iXZLt3orSpPSsZwBanzqhtpKz4jd1b6Wkm4E
         Y1sA==
X-Gm-Message-State: AOAM531vLOawnsiT+Yuerli75pBja0bK5XRTRgt3jjVYpmNFBay9GuwQ
        7E+KgbDcNNyIDxf2UcXa/PKH9q9I
X-Google-Smtp-Source: ABdhPJz7zfi5NGFalG9KUx50YaJnKaGXX5smeKmLFEVuxH5xNsTGw+zgcEAawu2twIf+CxzBGuJXkw==
X-Received: by 2002:adf:f64e:: with SMTP id x14mr1124524wrp.426.1591216228168;
        Wed, 03 Jun 2020 13:30:28 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id o10sm4854983wrj.37.2020.06.03.13.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 13:30:27 -0700 (PDT)
Subject: Re: [PATCH v3 07/13] PCI: brcmstb: Add control of rescal reset
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
 <20200603192058.35296-8-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3acb94da-e844-a2a9-fa05-755a97158322@gmail.com>
Date:   Wed, 3 Jun 2020 13:30:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603192058.35296-8-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/3/2020 12:20 PM, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Some STB chips have a special purpose reset controller named RESCAL (reset
> calibration).  The PCIe HW can now control RESCAL to start and stop its
> operation.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
