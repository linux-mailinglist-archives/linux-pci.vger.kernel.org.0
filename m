Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD43E136946
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 09:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgAJI4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 03:56:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45750 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgAJI4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2020 03:56:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so590616pls.12
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2020 00:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mtkMEc02hXcR+20gh5yanXRHRh9eVEHsJBoW93ABkXo=;
        b=YMENjTwxc2x1aZh9cvqZtVp9X+gzmXBfgyOFu25Rw9m4fkkrrKiShS8BtfH3gAqIA/
         foxdYZNNM7cFnVVnTQQnSqXg1J00PFqe4YPY8Aq6IgVBYin7QPVPD3WrOpT2zIHderyl
         V3RpHlCIpMrJvklAXVEELBgPliPXrGWqi5IXNcMgdvBd+PtFHZwFZRDiVzGAlzKPWekb
         aQdQLm941KrBHI8pXhX6fNx7nNQ8YP9aajNFwmRDva9AkSTjiLdZj8iU3+LtIb8K4sCj
         jNvL8EfIPdukdDJLXXzmelH5H4BH4VALKv6n2SwioemXe+ah4XmmXCWyaA1qZ80aufVj
         daNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mtkMEc02hXcR+20gh5yanXRHRh9eVEHsJBoW93ABkXo=;
        b=cycg9dYYQzxpj/tNP3SoXDQ7uyWaYxLaQ9z2cJC+LN0EAlN2QFcv8mBA6SiOEGFKc1
         E2RlvOxUuSc0bgWZtPIDg/WCuauOpgOmcOr/zu1An9ZfSN29uPfbsqdHyZYcIiYQnXc2
         mIJIIIL9mwHjVgMRETEZbWIPFUtfvNDOr+06q25SX/6dhc+cUE3RYY6IViCItWmo53Ad
         DKyDnI1e6VxopNOXTMk1h2U7fSvxd6lilrmADcBFcAHaY5tXLWyav6/DqaQprpoJYNv+
         imMmpWw1LNW8i/+WVdb6k/5T+5QaJPF6qRMH0c/Epet8VIFMQaFRTqg6L8bYMkMQxBkN
         H5pQ==
X-Gm-Message-State: APjAAAWz/3uQib9CunIgXCoFAR/D6Bs1FlMpEm2+xVh6u513AnnV9MAc
        dZTvin3gGn/p9iMpSmyUPcDC6Q==
X-Google-Smtp-Source: APXvYqwvvqWWDtlZMEyHeR3o0UJrf+fM/69T5OTeEzspifsxckyDh5dV2k+bJZqhudcsAanWCaCgmQ==
X-Received: by 2002:a17:90b:2286:: with SMTP id kx6mr3333120pjb.95.1578646596036;
        Fri, 10 Jan 2020 00:56:36 -0800 (PST)
Received: from T480 (98.142.130.235.16clouds.com. [98.142.130.235])
        by smtp.gmail.com with ESMTPSA id d14sm2079709pfq.117.2020.01.10.00.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 00:56:35 -0800 (PST)
Date:   Fri, 10 Jan 2020 16:56:28 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     linux-pci@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Zaihai Yu <yuzaihai@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: dwc: Separate CFG0 and CFG1 into different ATU
 regions
Message-ID: <20200110085626.GA17787@T480>
References: <20200109060657.1953-1-shawn.guo@linaro.org>
 <beda8923-a3b7-47eb-7cf1-19a3bacf1e34@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beda8923-a3b7-47eb-7cf1-19a3bacf1e34@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya,

On Thu, Jan 09, 2020 at 11:04:01PM +0530, Vidya Sagar wrote:
> 
> 
> On 1/9/2020 11:36 AM, Shawn Guo wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Some platform has 4 (or more) viewports.  In that case, CFG0 and CFG1
> > can be separated into different ATU regions.
> Is there any specific benefit with this scheme?

Thanks much for the question which leads me to go back to vendor for
checking design details of 4 (or more) viewports.

It turns out the patch is not complete.  We need more code change to
get the benefit of using separate ATU region for CFG0 and CFG1, that
is the dw_pcie_prog_outbound_atu() call in dw_pcie_access_other_conf()
function can  be saved.  But in the meanwhile, we need to pass
'va_cfg_base | busdev' as the first argument to dw_pcie_write/read()
in there.

@Lorenzo, @Bjorn,

Please ignore this patch.

Shawn
