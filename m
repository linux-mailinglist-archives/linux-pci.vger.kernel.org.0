Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D263320E400
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 00:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390575AbgF2VT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 17:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgF2Swt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2020 14:52:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB89DC030F1A;
        Mon, 29 Jun 2020 09:26:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q17so8109837pfu.8;
        Mon, 29 Jun 2020 09:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5bN7dM1qqkzB4oSQWgEANKrL9UtxJ99LWuqLjb9OuoE=;
        b=AM+F86QnW2dzuXU3xN50x8mxtIxp8MAvaG51U14uBQZANwaywi9RJ+1kPmsxLWdNbz
         Oz7D2XrVbGZrOdBM2XafDcXT59lRxbe8HjEfXzKVursxu53R/YHUzapucN4LV1Qs8SVg
         NBA+NyngwrwXir8jymJ5SeVr+ouHcmKkUN6XXSycq6lv0ztqhczxlAVdx0VdkAS2jFZx
         VuEEBOgm/nbU5D265WSsxOqWXDf055+iwB18+b2msEXjUg6bYm2pmmqmDxhpLic0Ps8l
         J7mtYxOuuuoBh+arYPJQFMpAQZvaK7W/dna+6ELTY6ZPrCyhMN10f12akiv5TmLtpV2d
         tmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5bN7dM1qqkzB4oSQWgEANKrL9UtxJ99LWuqLjb9OuoE=;
        b=NTl1bzPRy8bc0uRflZvf/THBAfNUkLqnWOU/hysci2psG8lNMX/iB0kMHRFnk32uVU
         RlKsUP16oB0CenGD+sR8GdDnnTTeM+UzYqckthzr9wKPVr4SQMfmCvG2BHpl4XbUa2DU
         EzRlP0t6yeFEP3exj2IJHUkl40De4gicv65i2dPLhheBW7VYVbwZ4o5dPoFwrZ658N2b
         ACfVI/mmwW7is3tEpd+OB4+8oXrzl2uEEKExfLDTIRkOzFad6TSUYjxzksvDTAHjtAJ/
         UOUnMkRj4lZwVrw/pSV66lAf9OJtlkgyYWSEWgwEbyKWTyoSVBpCDbAfqJeNH6C8CBuB
         K0Jw==
X-Gm-Message-State: AOAM53338/04zULAqCAqLOvqENYlj2KjlHYnbyyXDCUT2TN6kVUZrkEF
        xHk/AMDX7vFL8RG+wQ62470=
X-Google-Smtp-Source: ABdhPJxOQPZ5VFmxPB46o4lC3E9R6j/viT+gImLcBv1uOLQosHYqe3ny9PZ5EcX+8+KFNhUqQYtyFA==
X-Received: by 2002:a63:ab0d:: with SMTP id p13mr10958709pgf.327.1593448011387;
        Mon, 29 Jun 2020 09:26:51 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z11sm196296pfg.169.2020.06.29.09.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 09:26:50 -0700 (PDT)
Subject: Re: [PATCH v5 5/9] usb: xhci-pci: Add support for reset controllers
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de, andy.shevchenko@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mathias.nyman@linux.intel.com, lorenzo.pieralisi@arm.com
References: <20200629161845.6021-1-nsaenzjulienne@suse.de>
 <20200629161845.6021-6-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e9a52cf1-4786-d1c7-4d1e-1e619dfb37a8@gmail.com>
Date:   Mon, 29 Jun 2020 09:26:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629161845.6021-6-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/29/2020 9:18 AM, Nicolas Saenz Julienne wrote:
> Some atypical users of xhci-pci might need to manually reset their xHCI
> controller before starting the HCD setup. Check if a reset controller
> device is available to the PCI bus and trigger a reset.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
