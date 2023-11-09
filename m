Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD847E71C0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Nov 2023 19:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344997AbjKISwV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Nov 2023 13:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344959AbjKISwU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2023 13:52:20 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755DE3C10;
        Thu,  9 Nov 2023 10:52:18 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc9b626a96so9912085ad.2;
        Thu, 09 Nov 2023 10:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699555938; x=1700160738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOJwvxWy/qg4Uii7OOcQ3P1P+ebAD+J/sxGrJB+Tt8I=;
        b=ZZe+7FFAQ2j8xwiIywwGjSjuq9i9YI98rt3khJjC3c1144z36bB/tSUnOpsC5KiUW7
         f+Jodli3/QM+ZmZ/rXtnB8DNXyl6Z9AUTUsO39uk79tbyeLkr28xr4IuA6T1XQyFDE8K
         jtBaziG+/e6z6mb9qBH7N3vEYStmk/U6LXJEHExMF08V6kRLbM4JXQ6iRP4QzEEbHKOy
         WIAC1kFCPTtdB+FwwiL1Fw9iv8JUigHw407flVFwVIZBrzm0Z+V1bscqhtJ6mdclIGiW
         9x+47ahnnKnAU3N+qn/51khg836eSAO5VEimKCA7JG8QeySPisiMni16UwzhHD1LbjFw
         kxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699555938; x=1700160738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOJwvxWy/qg4Uii7OOcQ3P1P+ebAD+J/sxGrJB+Tt8I=;
        b=I7OGd2ZFNVIvaWd5yLSqPuLxEjR1ipisgwfg/7Ep4PE/Ko1CIyvBuPgvxxCmyQ4qAs
         Im7YRyFGrJ12twYHtMR7gUt73rlu4wNuzjlePG037x+3PkOqnQfDC7xg97gOpcg+8WT+
         yqja/gr3kzSKggnv+jaC5F5R4oFQ9YfA3CWtYAVxT3CqAaGbOp2lQE5tSjuO9PwMn+/p
         qgbnDzPAnr84gk0DdONkEjYD/AZhL6kAn0CwavIhXm6wZRtMcjGvp9sBvO+/Oq3aOs7U
         TA8uBHOihxPfIK9sqjL6dgq8iOuXz+iVw+kj+BVgLScdQRuydqpbNwh1qR0IZBKREhxV
         e4tA==
X-Gm-Message-State: AOJu0YynEaWeHxim0zCJzfSarRmQitcWUIFyhWJ7euonm/4GclaXPEyS
        aRnsxdSzhK6BfPoGAmlUJ6M=
X-Google-Smtp-Source: AGHT+IGEa/ADKkmacdMMkbkxEegVR+wrg/q/Cb1CKOTPJsyx20avzKAKNneewwQiGq9mVN0jP8cHOQ==
X-Received: by 2002:a17:903:32d1:b0:1cc:45d0:46fc with SMTP id i17-20020a17090332d100b001cc45d046fcmr7264610plr.54.1699555937771;
        Thu, 09 Nov 2023 10:52:17 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902aa4600b001c625acfed0sm3860747plr.44.2023.11.09.10.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:52:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 9 Nov 2023 08:52:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <htejun@gmail.com>, dakr@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, jeff@garzik.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Implementation details of PCI Managed (devres) Functions
Message-ID: <ZU0qYBfFzsF3e8S9@slm.duckdns.org>
References: <84be1049e41283cf8a110267646320af9ffe59fe.camel@redhat.com>
 <1e964a74ca51e9e28202a47af22917e468050039.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e964a74ca51e9e28202a47af22917e468050039.camel@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, Philipp.

On Wed, Nov 08, 2023 at 10:02:29PM +0100, Philipp Stanner wrote:
...
> That struct keeps track of the requested BARs. That's why there can
> only be one mapping per BAR, because that table is statically allocated
> and is indexed with the bar-number.
> pcim_iomap_table() now only ever returns the table with the pointers to
> the BARs. Adding tables to that struct that keep track of which
> mappings exist in which bars would be a bit tricky and require probably
> an API change for everyone who currently uses pcim_iomap_table(), and
> that's more than 100 C-files.
> 
> So, it seems that a concern back in 2007 was to keep things simple and
> skip the more complex data structures necessary for keeping track of
> the various mappings within a bar.

It was so long ago that I don't remember much but I do remember taking a
shortcut there for convenience / simplicity. I'm sure it's already clear but
there's no deeper reason, so if you wanna put in the work to make it
consistent, that'd be great.

Thanks.

-- 
tejun
