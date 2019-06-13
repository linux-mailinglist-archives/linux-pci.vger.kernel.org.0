Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF7439F3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbfFMPRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:17:35 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39381 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732186AbfFMNWi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 09:22:38 -0400
Received: by mail-yb1-f195.google.com with SMTP id y17so509177ybm.6
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2019 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=heTVmTA1VC7+Lv8ssRiXzCfaW/u+s8AFPCxrnLoG20c=;
        b=TFX6C5Y4JreIdr5ZV52Pg4p+F418M647OuPDyzeXbDSVvH+R/5Zoee93Sla1Lbup67
         qYBcxQCxAoz75kNfrbjm0/gm+TxtkkLbeHpFdOfnEUJvqkn41wKMKN57rJ1abwxwd0W5
         14J9HQSzXRuEFr9RLx8R0j7X7OcO9bbPnoTysdrOpY5WFLIKh1UoypwO+7yFa3628eyS
         ra5v07Dnlg9G5UyLWIHo783FIGtJolo3QERz2/FXUBpleUnBA7dpPEW61OMWl45KlaBP
         3fZ4nxGd6/3E6pCI0rtaVh16owpZTDRzYE2kKtxOjBDQSnTgiUdIH6SXvhGgrcdoWB8K
         FOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=heTVmTA1VC7+Lv8ssRiXzCfaW/u+s8AFPCxrnLoG20c=;
        b=CxJtHRfXZ017FMygIOE6STN3B+tlZGU2yqhLJLFw8I6823ZFxfQHAdV/qXyHx366Df
         fIqbCeepNBaXYm670JtqXpsgsH4okQ+y1+xcqQVyMLmHNInIPxUPyBAvpDz1W5qi1thG
         7zypmi5+WR4tIF0AIbiOFs/nLFucT5/VFz1lii/kGXyGZ9FMqkbUExkvwuGV/krrTR8I
         kvSXsNFkpWOHc5njj8Sd+6Ss66W1I3bSCn+CnJX6t4GjQ1dISOnSY03/7+hS0nMcDsjH
         N7UkYoQcb5yAhqvEaVMFkXvxTNyXo6KWDt/7Gd2m5sVTZMGXuEiwS21eWRbSedeSO/3H
         vQng==
X-Gm-Message-State: APjAAAWnKl9u+sylk3RBSteyOD4xmkFnmaQhNzhmOIeVYuLcB5NchhmS
        XLESlgzJ/pMxsmaH3symoqHIMs/asKweJIvk
X-Google-Smtp-Source: APXvYqyuV0U+ZNI/ZQHhffAIzXID47tvMONU2SVXHb7+Z4fbsGfcAyNC9oPmga8HohImAuiCY+oKtw==
X-Received: by 2002:a25:6089:: with SMTP id u131mr12942461ybb.14.1560432157816;
        Thu, 13 Jun 2019 06:22:37 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id f206sm759183ywf.77.2019.06.13.06.22.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 06:22:37 -0700 (PDT)
Date:   Thu, 13 Jun 2019 09:22:35 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Kelvin Cao <kelvin.cao@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        kelvincao@outlook.com
Subject: Re: [PATCH 0/3] Redundant steps removal and bug fix of
 ntb_hw_switchtec
Message-ID: <20190613132234.GA1572@kudzu.us>
References: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 06, 2019 at 03:09:41PM +0800, Kelvin Cao wrote:
> Hi, Everyone,
> 
> This patch series remove redundant steps and fix one bug of the 
> ntb_hw_switchtec module.
> 
> When a re-initialization is caused by a link event, the driver will
> re-setup the shared memory windows. But at that time, the shared memory
> is still valid, and it's unnecessary to free, reallocate and then
> initialize it again. Remove these redundant steps.
> 
> In case of NTB crosslink topology, the setting of shared memory window
> in the virtual partition doesn't reset on peer's reboot. So skip the
> re-setup of shared memory window for that case.
> 
> Switchtec does not support setting multiple MWs simultaneously. However,
> there's a race condition when a re-initialization is caused by a link 
> event, the driver will re-setup the shared memory window asynchronously
> and this races with the client setting up its memory windows on the 
> link up event. Fix this by ensure do the entire initialization in a work
> queue and signal the client once it's done. 
> 
> Regard,
> Kelvin
> 
> --
> 
> Changed since v1:
>   - It's a second resend of v1

Sorry for the delay.  The series is now in the ntb branch.  We've
missed window for 5.2, but it will be in the 5.3 pull request.

Thanks,
Jon

> --
> 
> Joey Zhang (2):
>   ntb_hw_switchtec: Remove redundant steps of
>     switchtec_ntb_reinit_peer() function
>   ntb_hw_switchtec: Fix setup MW with failure bug
> 
> Wesley Sheng (1):
>   ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window
>     for crosslink case
> 
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 80 +++++++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 31 deletions(-)
> 
> -- 
> 2.7.4
> 
