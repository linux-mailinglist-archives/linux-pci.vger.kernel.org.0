Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A833534B6D7
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 12:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhC0Lck (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 07:32:40 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44793 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhC0Lck (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 07:32:40 -0400
Received: by mail-wr1-f48.google.com with SMTP id c8so8079839wrq.11
        for <linux-pci@vger.kernel.org>; Sat, 27 Mar 2021 04:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GSs69PYJcIHQ6+xxQ5SvqpG1ljoeGwSlyKoNuOWFuaM=;
        b=cU3TWz/7YQjRxKU8IliPnuyir7tUlK/3aDE1GBv4ZDIuF/z+OfUzYVLtNh466l5NqI
         Tw0T8Tj0E3jxG3bLUBd90tQDMy/UgW7KfbJBjnfxy3QlaG6DZsIgbOrnBgcie1nL/Hup
         JHsubWyEJAodPBFJWZyLjeDzLXNZgqMeql7l7GNBRcUdMVckJyQXr0lVWhkCiyUODP78
         t9m9qMyMpUEAE6rI+LInifnwNkREMjLxebyplaupJct2fadcEwQ+fWuV7q/H92fdo3CL
         yohgWmpVWfp/UZLIhK7QdkNMFK+fRB4sJ/YN6WiEN+WUduBJA2d5XXtOxtKRvOdZu/2P
         KbGg==
X-Gm-Message-State: AOAM533epnBBA7hmDI0TzVBGzouVxWxXMXtnEx5BYiMXb0ygIzETzJnM
        4OjIx4tVNGbqA+HZD6XbT54=
X-Google-Smtp-Source: ABdhPJw8tk4k/KA03MEz5dLf6p0d9i9bc26G8aEWJVL0wyZOkfrcLeQh+JjSVqzQ3GLife3vmov1xQ==
X-Received: by 2002:adf:d0c3:: with SMTP id z3mr19510555wrh.28.1616844758818;
        Sat, 27 Mar 2021 04:32:38 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d13sm18951703wro.23.2021.03.27.04.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 04:32:38 -0700 (PDT)
Date:   Sat, 27 Mar 2021 12:32:37 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, wangzhou1@hisilicon.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: hisi: Delete the useless HiSilicon
 PCIe file
Message-ID: <YF8X1V0PkmMk4fHR@rocinante>
References: <1616842062-21823-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616842062-21823-1-git-send-email-liudongdong3@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Such a strong word "useless" in the subject.  I would think that the
file became "obsolete". :-) (N.B. nothing to fix, though).

> The hisilicon-pcie.txt file is no longer useful since commit
> c2fa6cf76d20 (PCI: dwc: hisi: Remove non-ECAM HiSilicon
> hip05/hip06 driver), so delete it.

Thank you for cleaning things up!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
