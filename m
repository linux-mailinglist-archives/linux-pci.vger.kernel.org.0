Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3E321C317
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 09:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgGKHri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jul 2020 03:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgGKHri (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jul 2020 03:47:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51649C08C5DD;
        Sat, 11 Jul 2020 00:47:38 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ch3so3563958pjb.5;
        Sat, 11 Jul 2020 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vVj5PLO8DWwXrIdgpAWOr+iuRE5LhehahqytWj2/7fQ=;
        b=hDSb2sNvIipGw4oind1DIUmZ7pWoWmWG0jzZVbbiWW5Mo5Zjwg98cqGJfgiMI8VFMB
         GtJmgwetBfTsfJqIcnZKU4sTLz0WVJoX6ns/LQu6LcEDpHSNqYfRLTQccPPHeq7uM+Lr
         RH8y8qEuBlRofCc5r+qZv3KhJWTGDt+lxZ52mVboGqVSO6oP2rsgxo05cYt84xmLM18q
         Q6sOfj3Wta2MFM7DijoTNwBZ+gBlcYCgknhT4srf2ABpetYuZgTF54LvLLvlQ4KhjROv
         LzgpKYAa2bKI9AFbYT+LZay8KW4ubsE/B7kkeHBjt272KGaceXV7xN+SsxtFvyIyr8SS
         AUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vVj5PLO8DWwXrIdgpAWOr+iuRE5LhehahqytWj2/7fQ=;
        b=hTZtl+zk4ehhfL9LEyK3hkbNtHZX/ln2JBIyceSTmMQQ4JOEU+QjFUZvmjlqXP5DvO
         8fXurik/ossNzCnXOg0E5viGtWbrngcHZzWeYm4wTjPf8GgnicD2tStjjUgu25C3U0sL
         N7AGNwW3XpItv2vnHnEWwXYQOZqFGBRoLIm+mHEMoFMEF7pbLjku5gYr235OPPhougKG
         H6j+crhSicY7C1J+3+qxxY0alEMQlBXVS1YtttvDhfFzLSdHgRwyTwxY4O8NGU7chDj8
         f4bZ03C3g4qL8q2BLeGDTNX177nz6l95QT6+543cdbMya/Xs7VrJW9kQ1wmoVmOOuD8G
         gngg==
X-Gm-Message-State: AOAM5303VzU5cdssXbiP8AABbR9GGD1XJldSPu3U82Qwe/Xnkf6mLFJr
        pl7cv1ueJCap/r+pdHGeQokkHkmh
X-Google-Smtp-Source: ABdhPJxlAglX382X0f1/g7QbU/5vlbVEeMt5hUYKqbYmx+IOUtoIvXwQrWvqL0CtYA5XKDqGmt264A==
X-Received: by 2002:a17:90a:454f:: with SMTP id r15mr9530287pjm.6.1594453657844;
        Sat, 11 Jul 2020 00:47:37 -0700 (PDT)
Received: from localhost ([89.208.244.139])
        by smtp.gmail.com with ESMTPSA id g8sm7823345pgr.70.2020.07.11.00.47.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Jul 2020 00:47:37 -0700 (PDT)
Date:   Sat, 11 Jul 2020 15:47:33 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: controller: Remove duplicate error message
Message-ID: <20200711074733.GD3112@nuc8i5>
References: <20200526150954.4729-1-zhengdejin5@gmail.com>
 <1d7703d5c29dc9371ace3645377d0ddd9c89be30.camel@amazon.com>
 <20200527132005.GA7143@nuc8i5>
 <1b54c08f759c101a8db162f4f62c6b6a8a455d3f.camel@amazon.com>
 <CAL_JsqJWKfShzb6r=pXFv03T4L+nmNrCHvt+NkEy5EFuuD1HAA@mail.gmail.com>
 <20200706155847.GA32050@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706155847.GA32050@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 06, 2020 at 04:58:47PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jun 02, 2020 at 09:01:13AM -0600, Rob Herring wrote:
> 
> [...]
> 
> > > The other 2 error cases as well don't print the resource name as far as
> > > I recall (they will at least print the resource start/end).
> > 
> > Start/end are what are important for why either of these functions
> > failed.
> > 
> > But sure, we could add 'name' here. That's a separate patch IMO.

Hi Lorenzo, Bob and Jonathan:                                                                                                     

Thank you very much for helping me review this patch, I sent a new patch
for print the resource name when the request memory region or remapping
of configuration space fails. and it is here:
https://patchwork.kernel.org/patch/11657801/

BR,
Dejin

> 
> I agree. In sum, I think it is OK to proceed with this patch, provided
> we send follow-ups as discussed here, are we in agreement ?
> 
> Lorenzo
