Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9FD22BE4
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2019 08:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfETGKR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 May 2019 02:10:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43548 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfETGKR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2019 02:10:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id t22so6229662pgi.10;
        Sun, 19 May 2019 23:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EtCrzdF26Only4uUvmUSQS6DqLBRvSsL0zNTScPkmCA=;
        b=S5GgdV/JlgWXgEzAK5a6Fs1L8HVPSgtNmWwZ1fLgEQbPK6mKX2B7Qz1TybIVsdHYRj
         PGLn5Xqc4X3qS0Y2rLNS3kZePMLn1sXbnoCVEx7NEGiWS/VAgItngZ5Yur6A/D1MhQze
         nZ7sGQXyO/rIIvxrsCng3hjDv3Xr4m3KK/blQcZdZLXKw4+HoSktKC5t24yOnGhVHkwQ
         kZhomS5aMVQYkPUjT+JX6/Li51j44O4p6bMQnZsl2VZ0Zrrn0aZIL7QqOmx3Aj/X3mLp
         lh8IrYe8DU1cWuDXl5ved9UTWdeAMwGkut+DhkYcEaRoBdIXI5U0DAvF9sceuZlHiieG
         O1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EtCrzdF26Only4uUvmUSQS6DqLBRvSsL0zNTScPkmCA=;
        b=FgCikrgWXmFYGi214R8dAlBta2pEeuVbi0JMiSVgWqW9rPxFxyaaQVLd2hGBTBXNL5
         rnueJDu/wmv5Fy8Rg+y5sxyMzHeQ1gDNVYkWpZM6rAjmqaRamxatCa4arO+65IcDtVbR
         +9upj8bAyX5IQm9Pg/Sla6ZHnbwBhzFqD4jm6pBwBKBpunBoexIJWW6KI/almWb8dWvz
         Y7Ejh0qr4VcA9Z7eDphmR2s6SqMFZNOdqPqeqAGWylEMnIiYmJreVILWxD2QaILPQKaj
         RakLugiGYMDI7+74iIBVlx6ogKa3y8TMFqHtWLjXPQxK2i2RPDTHwSt39apXhv0xxLsj
         165g==
X-Gm-Message-State: APjAAAW2ZvIQWXrPjESwvcnPdCXig97Ax6FoCNA4Xhly+yc57QjNgoa9
        nho/sD5ETSqQmIuaMq6Ii0E=
X-Google-Smtp-Source: APXvYqx2+ES/Zm6mJG5Ui9U/ofzrn8oYSPp+hHXhmZR0UKq0PWWOZ4+HuGiv4oMvYgBzG5bsJ6oFTw==
X-Received: by 2002:aa7:8a11:: with SMTP id m17mr55997757pfa.122.1558332616888;
        Sun, 19 May 2019 23:10:16 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id a9sm24734044pgw.72.2019.05.19.23.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 23:10:16 -0700 (PDT)
Date:   Mon, 20 May 2019 06:10:15 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        changbin.du@gmail.com
Subject: Re: [PATCH v6 00/12] Include linux PCI docs into Sphinx TOC tree
Message-ID: <20190520061014.qtq6tc366pnnqcio@mail.google.com>
References: <20190514144734.19760-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514144734.19760-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn and Jonathan,
Could we consider to merge this serias now? Thanks.

On Tue, May 14, 2019 at 10:47:22PM +0800, Changbin Du wrote:
> Hi all,
> 
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted most of the Linux PCI docs to rst
> format in this serias.
> 
> For you to preview, please visit below url:
> http://www.bytemem.com:8080/kernel-doc/PCI/index.html
> 
> Thank you!
> 
> v2: trivial style update.
> v3: update titles. (Bjorn Helgaas)
> v4: fix comments from Mauro Carvalho Chehab
> v5: update MAINTAINERS (Joe Perches)
> v6: fix comments.
> 
> Changbin Du (12):
>   Documentation: add Linux PCI to Sphinx TOC tree
>   Documentation: PCI: convert pci.txt to reST
>   Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST
>   Documentation: PCI: convert pci-iov-howto.txt to reST
>   Documentation: PCI: convert MSI-HOWTO.txt to reST
>   Documentation: PCI: convert acpi-info.txt to reST
>   Documentation: PCI: convert pci-error-recovery.txt to reST
>   Documentation: PCI: convert pcieaer-howto.txt to reST
>   Documentation: PCI: convert endpoint/pci-endpoint.txt to reST
>   Documentation: PCI: convert endpoint/pci-endpoint-cfs.txt to reST
>   Documentation: PCI: convert endpoint/pci-test-function.txt to reST
>   Documentation: PCI: convert endpoint/pci-test-howto.txt to reST
> 
>  .../PCI/{acpi-info.txt => acpi-info.rst}      |  15 +-
>  Documentation/PCI/endpoint/index.rst          |  13 +
>  ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} |  99 ++---
>  .../{pci-endpoint.txt => pci-endpoint.rst}    |  92 +++--
>  ...est-function.txt => pci-test-function.rst} |  84 +++--
>  ...{pci-test-howto.txt => pci-test-howto.rst} |  81 ++--
>  Documentation/PCI/index.rst                   |  18 +
>  .../PCI/{MSI-HOWTO.txt => msi-howto.rst}      |  85 +++--
>  ...or-recovery.txt => pci-error-recovery.rst} | 287 +++++++-------
>  .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 161 ++++----
>  Documentation/PCI/{pci.txt => pci.rst}        | 356 ++++++++----------
>  .../{pcieaer-howto.txt => pcieaer-howto.rst}  | 156 +++++---
>  .../{PCIEBUS-HOWTO.txt => picebus-howto.rst}  | 140 ++++---
>  Documentation/index.rst                       |   1 +
>  MAINTAINERS                                   |   4 +-
>  include/linux/mod_devicetable.h               |  19 +
>  include/linux/pci.h                           |  37 ++
>  17 files changed, 938 insertions(+), 710 deletions(-)
>  rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (96%)
>  create mode 100644 Documentation/PCI/endpoint/index.rst
>  rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
>  rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (83%)
>  rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (55%)
>  rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (78%)
>  create mode 100644 Documentation/PCI/index.rst
>  rename Documentation/PCI/{MSI-HOWTO.txt => msi-howto.rst} (88%)
>  rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (67%)
>  rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)
>  rename Documentation/PCI/{pci.txt => pci.rst} (68%)
>  rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (72%)
>  rename Documentation/PCI/{PCIEBUS-HOWTO.txt => picebus-howto.rst} (70%)
> 
> -- 
> 2.20.1
> 

-- 
Cheers,
Changbin Du
