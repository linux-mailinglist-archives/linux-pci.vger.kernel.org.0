Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CEB86CF8
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 00:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfHHWNO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 18:13:14 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37044 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbfHHWNO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 18:13:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so59495396otp.4
        for <linux-pci@vger.kernel.org>; Thu, 08 Aug 2019 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QAveB2MW5aJCL42pdrRo0A2p3FoeHwf0+C7PsDEtr8A=;
        b=BYh3CXmpTdLhzlZKIWTS8wOiE1OOGf9hls2ts3bYz7IveQviKpWWqIgibdewQlI/V0
         bnjk37YFfE6sgM8hrsj1fuNTcN44llGXOqtbclPgC6p1fVnUUAd8ALIcpBm+ZjLWnwfi
         +ER3HzavOE3pgbXBU+FsmTQRfpeI78xD3Ppwl/MyXIBZtjmYfOOL6XyaBXGot7zZHq2K
         GP2NsSb/pb6jBVogIgEhzwOFp5bl1GPq502b3f+b4e3lNQxiSH0BAOt/Z0bLNls5hQmG
         UxceZu66FYwoLYmp6J+3+/qh1D5I11XIzY0q8b+YtWdiZBmgm7xellduUI32H4JiGWbB
         17MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QAveB2MW5aJCL42pdrRo0A2p3FoeHwf0+C7PsDEtr8A=;
        b=Fdb7xhmwC6RQ0KqB8mlAf5GCXSYii+ZwWLe7mHTXHn+6jEmp8IBL73Ik/TwfeDFZUv
         nIEgZ1isWWx+FtoljRHQMUoWy5Suqk6ptwgyqoPmaD1mp4oyIkACgn8I/iXeKbVASC5q
         V23b9icE5J82xs0D4G0HD8TwA+TIguOvXVXJAZlyFplmKf7+R7Xz3/2eKbXVbqHgffKw
         9U2EyICZfr0mvicaEPiDnFwUIuyUyQir+P5K77Q+ff5DsgHzhjsCD+CPymKXFv7K5red
         Ydfk4sVj7WmcHlWJ6wfe5SFQ1K8RbYmBAkee1ydepuDl2gAlJw5aupuBkv83fz9MSTQN
         EHnQ==
X-Gm-Message-State: APjAAAWuDiM9I6XFvPQ2UmdcZX9OwjuPuOruVwWMGlV1/mP03LszTrQZ
        PlcFJadDu9DNfJ7ukNGOtPuhtQ==
X-Google-Smtp-Source: APXvYqw6s/RyB6V5j4rVM86HvbsgecZHQYSNieyQsEmT4pWYa+NHHnA6N9MkEh+XkeHSxuIzd+PxoA==
X-Received: by 2002:a5d:9acf:: with SMTP id x15mr16478208ion.190.1565302393249;
        Thu, 08 Aug 2019 15:13:13 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id h19sm63989093iol.65.2019.08.08.15.13.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 15:13:12 -0700 (PDT)
Date:   Thu, 8 Aug 2019 15:13:11 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Wesley Terpstra <wesley@sifive.com>
Subject: Re: [PATCH v2] pci: Kconfig: select PCI_MSI_IRQ_DOMAIN by default
 on RISC-V
In-Reply-To: <20190808214728.GC7302@google.com>
Message-ID: <alpine.DEB.2.21.9999.1908081512200.6414@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1907251426450.32766@viisi.sifive.com> <20190808195546.GA7302@google.com> <alpine.DEB.2.21.9999.1908081349210.6414@viisi.sifive.com> <20190808214728.GC7302@google.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Aug 2019, Bjorn Helgaas wrote:

> Indeed, sorry I missed it.  I generally work based on -rc1, and it
> looks like 251a44888183 was merged after -rc1.
> 
> Since we're after the merge window, the default target would be v5.4,
> but I see some post-rc1 pull requests from you, so if you need this in
> v5.3, let me know.
> 
> I applied your patch to pci/msi for v5.4 for now.

v5.4 is fine - thanks.


- Paul
