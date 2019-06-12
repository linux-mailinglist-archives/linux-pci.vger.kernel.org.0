Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF5D4294C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 16:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfFLOdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 10:33:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43508 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfFLOc7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2019 10:32:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so7074374wru.10;
        Wed, 12 Jun 2019 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUKqGe05Pb6zgw6RDjd1axpDapyL2aMPUaJVO2AtScM=;
        b=bj6+TzQSyieda9nmrZY4Os4EedFMWvAOj6ovbGm7q1WpWQFZ1HeHCX2nwODrvwlxP6
         5IQ522sEtOi3ICjg0+i/y8cKg75qr5K4jQi6qlRzHsYG/HYgK2oeXYj9tWOYZNGh70/l
         Nt5x574vpGVY1Ql6YzzgLMjyz2XswYllUduLSkbjww9xLvuD+mc0GBDL/beotOHNi9WP
         zKji8Z9S0k1Ehoi6hqWO2gOVedlLjJAwRQeysd9iODRo2NiQ4v2w4jxnb8N6WNwAADMx
         KVswqRnyD/4x7DIldBtJfr5eKqzRnVAkTfrBlBvlB+y9kpXUWRtKrS8W8gd2G5tGS5tJ
         KOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUKqGe05Pb6zgw6RDjd1axpDapyL2aMPUaJVO2AtScM=;
        b=YXGRUSfKmW+O2mv0/u5vosMulKlQVA9Pjcl+4BaOlPWhRsuaM4JYYhBwEALwN5lS03
         jmXM12185FrfJAl1Nu1Bxq0GT2sgEBNRVijZ5x4PP/2F25yGSmhI9L/U4hseAPWAm2VH
         cnCLw6tWOnwdc6dCm2iNiKEVpaCthvtm6fA7R2A6fNgzLLQ6mGbuBqzrDhS8kVLWIMzG
         w95bwv/idDR4dIvEA7DasfMT+j7P2KzPW/2l1c0VJcLe6ajlex/WB6um4Ccnsodxm9Gz
         U+jmX3gLsH++aQxdZtfUWL9pgsUjFh09X0ABp4kPwlLMN5U/xBLKhmwh4B3mhR7Yfqwx
         DRow==
X-Gm-Message-State: APjAAAUxL4a5l1Mr1sS1nigyPk1j0JzwRgFQgN8UB9zIXO2ZUw2kPKRD
        YpeL4KVtQ9oX6MvakhyJ7JpbGnQ9JkvRv0aSrcKXrOM4ntQ=
X-Google-Smtp-Source: APXvYqwUKKVE25V0R6QySoA81QTCMxX2IWB6TzJCr4k/wQYSrpB32IZNfVDUYrZQwa+dGzVnnVKyF0vtLb/TF/Y9OBg=
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr55904909wrw.306.1560349978526;
 Wed, 12 Jun 2019 07:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190610074456.2761-1-drake@endlessm.com> <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
In-Reply-To: <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
From:   Keith Busch <keith.busch@gmail.com>
Date:   Wed, 12 Jun 2019 08:32:46 -0600
Message-ID: <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
To:     Daniel Drake <drake@endlessm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-ide@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 10, 2019 at 8:46 PM Daniel Drake <drake@endlessm.com> wrote:
> What's the specific problem that you see here?

Performance. Have you had a chance to benchmark these storage devices
comparing legacy vs MSI interrupts? I don't think anyone would chose
the slower one on purpose. These platforms have an option to disable
raid mode, so the kernel's current recommendation should be the user's
best option.
