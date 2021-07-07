Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A73BF088
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 21:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhGGTyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 15:54:49 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:46000 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhGGTyt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jul 2021 15:54:49 -0400
Received: by mail-ed1-f46.google.com with SMTP id t3so4952192edt.12;
        Wed, 07 Jul 2021 12:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=URduaW50lsVABZMTcWqniUjdimmoK+Mx3tzbD4O0S0c=;
        b=tp7LDq7q84kwrouqsTlh5IG8bskNwTRRGMlKD+B86oeVds6X8Rta0STLCkCzVP7rlH
         rZT/B696cba7p3B3lbQXTxopJY6V7EHKSxxIVm+q6V+KTXblUn++jjswea1nvYlWQiGg
         CEA57KAG+c+XPKUkJkiZFOJiDFMIfoO9nreVHeL3jE02sZMy/5mqI8FDI7xNQGOOWpDj
         V03tGmlM2M2NW9beIuMTsjriqHruAzzb8jn92HBLqvUd9c84W9pxvqfLT4NBm5PL+Bji
         0LFPe1Z8LKBNwJq096yZnDseesKeC/XrjL8CI9kM1K947+2JrcuUmVHw6wMRnsXSmMTv
         cLaw==
X-Gm-Message-State: AOAM5306xeZqKoa8pZ0kdpzS4A4fnuIgOi0aJa+Esadwxp7+1u6+rn7c
        r46j6lzPrnAFUb4SOE92kts=
X-Google-Smtp-Source: ABdhPJwczzpgZW/l6CYw6xMSEcrMRQzjEX1rXbOx0YnkNsKZDpnFuKYfvJLKK5FguvXS8xtQAKUuUQ==
X-Received: by 2002:a05:6402:30af:: with SMTP id df15mr3080906edb.19.1625687527405;
        Wed, 07 Jul 2021 12:52:07 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f9sm24949edw.88.2021.07.07.12.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:52:06 -0700 (PDT)
Date:   Wed, 7 Jul 2021 21:52:05 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     thierry.reding@gmail.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: tegra: make const array err_msg static
Message-ID: <20210707195205.GA6952@rocinante>
References: <55b11e9a7fa2987fbc0869d68ae59888954d65e2.1620148539.git.christophe.jaillet@wanadoo.fr>
 <5f3f35296b944b94546cc7d1e9cc6186484620d8.1620148539.git.christophe.jaillet@wanadoo.fr>
 <20210705223152.GA142312@rocinante>
 <a3d48884-9e47-8623-6fc5-6c52f4ca0568@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3d48884-9e47-8623-6fc5-6c52f4ca0568@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christophe,

[...]
> > These should be trivial to fix.  The two pertaining to "quoted string
> > split across lines" would be something that we might or might not decide
> > to do anything about this - technically, as per the Linux kernel coding
> > style [1], we ought to fix this... but, this particular case is not
> > a terrible example, so I will leave this at your discretion.
> > 
> > What do you think?
> 
> Hi,
> I don't think it worth it.
> 
> Even for patch 2/3 about 'seq_printf' --> 'seq_puts' conversion, I'm not
> fully convinced myself that is useful.

I personally believe it's a good change.

For a literal string without any formatting using the seq_printf() is
much more involved for no reason, but aside of this small performance
improvement, it also has some value in demonstrating the correct usage
patterns - people spent more time reading kernel code and looking at how
to do things and use things to base their work on, so setting some
example is not a bad idea.

Albeit, it's a matter of point of view too, I suppose.

> Too trivial clean-ups only mess-up 'git blame' for no real added value.

Yes, there is a fine line with these.

> If you want these clean-ups, I can send a patch for it, but checkpatch
> output need sometimes to be ignored on files already in the tree. At least,
> this is my point of view.

No worries!  Thank you for giving it some thought!  I appreciate it. :)

	Krzysztof
