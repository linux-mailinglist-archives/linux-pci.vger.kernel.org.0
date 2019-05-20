Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC12823B8F
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2019 17:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfETPFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 May 2019 11:05:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33889 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfETPFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2019 11:05:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id n19so7383346pfa.1;
        Mon, 20 May 2019 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rKJ5kTZSuGMm/2HLLSWO6tchZr7oIUiwIHVknRGxIHU=;
        b=DFFPZRfieSKMQoNbbJCynO4C9ofYAqkO//Vr1ugsgNL47DpyGPpAJgCfSoq7K40686
         Y7s2odYbCVF5CMowkWDns6mUtJwyxjwomvPK62Ai1fGfzAZ6bDEO0vp5mpxSN1VfVQkw
         QqIgikEldr9Mv2FGZ3UzN1mIlfV8ENg6z8LGRobHVzuV6dvkDlLeQXH0yo2mjt72kms7
         RKMvL90OJ+WsNCe9qFZSsJTFCRtyq4of31EOPOusgyRYYiRlSPvAETZgi4XgrizN/GYi
         TM/GjkmhQct/tOE8Ive36X/+sI0A0acndA0povoOB91qiLG5U6EeJrAGUxpzngRfRIs5
         6NUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKJ5kTZSuGMm/2HLLSWO6tchZr7oIUiwIHVknRGxIHU=;
        b=POkC4x9yZLlBe5GmjEFB632b4jk8JWiBMl4wPAjfI9Qg7eC55UWOSSical8bvRbNuT
         zK4cKQ9eSww6DBWrlLWAsGzAZqOCuBCXh8olkDnlPvP7qDO3wxKWZl/x1DylzRa6kcAT
         78/DyHIDzZp1YIekiJk1h3tnROrJR3pTDXjA5xJs121qgTecxq3+pKGSfIwOyZ2tob+0
         JFWW2DkDaJSnt8DSv1zOKjX5Gs4K3Ff6i7og1zIx7HXRCUK6mdhPNzs8Kr2dIYE3drxZ
         QSql4LqpwUGosNZSKOXelS5CW8aabte9Ygsf4hujd4iC4noNl5EH51aK1O0lKkqnW8NA
         X5fA==
X-Gm-Message-State: APjAAAXk9uwLR9O7ARGleIiH893oIcAmw23LjbBt9enC0QfK7HlUDbdW
        Sgq0nQeoX4rdcbES8lQ4NjM=
X-Google-Smtp-Source: APXvYqzRsoqBeRY/wkEyhJD6yAUS3XYq7VZA7WQYO0XZtKOmxmQdJe0ecw/gzqmVXri37BYOOfRvVA==
X-Received: by 2002:a65:4544:: with SMTP id x4mr52855107pgr.323.1558364746528;
        Mon, 20 May 2019 08:05:46 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 187sm24722081pfv.174.2019.05.20.08.05.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 08:05:46 -0700 (PDT)
Date:   Mon, 20 May 2019 23:05:39 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, bhelgaas@google.com,
        corbet@lwn.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/12] Include linux PCI docs into Sphinx TOC tree
Message-ID: <20190520150538.hq4jnqeugpucjtwo@mail.google.com>
References: <20190514144734.19760-1-changbin.du@gmail.com>
 <20190520061014.qtq6tc366pnnqcio@mail.google.com>
 <20190520112350.4679df1c@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520112350.4679df1c@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 20, 2019 at 11:23:50AM -0300, Mauro Carvalho Chehab wrote:
> Em Mon, 20 May 2019 06:10:15 +0000
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > Bjorn and Jonathan,
> > Could we consider to merge this serias now? Thanks.
> 
> Before merging it, did you check if the renames won't cause broken
> reference links? There were such breakages with your x86 and acpi
> patch series. I'm sending the fixes right now, but it would be
> great if you could run the ./scripts/documentation-file-ref-check
> script and address any file name change this series would be
> introducing. There's even a --fix option there that allows
> to automatically fix them (you need to double-check the results).
>
I just ran documentation-file-ref-check, and *no* broken reference found in PCI
documentation. This tool is great!

> Regards,
> Mauro
> 
> > 
> > On Tue, May 14, 2019 at 10:47:22PM +0800, Changbin Du wrote:
> > > Hi all,
> > > 
> > > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > > from reStructuredText files. I converted most of the Linux PCI docs to rst
> > > format in this serias.
> > > 
> > > For you to preview, please visit below url:
> > > http://www.bytemem.com:8080/kernel-doc/PCI/index.html
> > > 
> > > Thank you!
> > > 
> > > v2: trivial style update.
> > > v3: update titles. (Bjorn Helgaas)
> > > v4: fix comments from Mauro Carvalho Chehab
> > > v5: update MAINTAINERS (Joe Perches)
> > > v6: fix comments.
> > > 
> > > Changbin Du (12):
> > >   Documentation: add Linux PCI to Sphinx TOC tree
> > >   Documentation: PCI: convert pci.txt to reST
> > >   Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST
> > >   Documentation: PCI: convert pci-iov-howto.txt to reST
> > >   Documentation: PCI: convert MSI-HOWTO.txt to reST
> > >   Documentation: PCI: convert acpi-info.txt to reST
> > >   Documentation: PCI: convert pci-error-recovery.txt to reST
> > >   Documentation: PCI: convert pcieaer-howto.txt to reST
> > >   Documentation: PCI: convert endpoint/pci-endpoint.txt to reST
> > >   Documentation: PCI: convert endpoint/pci-endpoint-cfs.txt to reST
> > >   Documentation: PCI: convert endpoint/pci-test-function.txt to reST
> > >   Documentation: PCI: convert endpoint/pci-test-howto.txt to reST
> > > 
> > >  .../PCI/{acpi-info.txt => acpi-info.rst}      |  15 +-
> > >  Documentation/PCI/endpoint/index.rst          |  13 +
> > >  ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} |  99 ++---
> > >  .../{pci-endpoint.txt => pci-endpoint.rst}    |  92 +++--
> > >  ...est-function.txt => pci-test-function.rst} |  84 +++--
> > >  ...{pci-test-howto.txt => pci-test-howto.rst} |  81 ++--
> > >  Documentation/PCI/index.rst                   |  18 +
> > >  .../PCI/{MSI-HOWTO.txt => msi-howto.rst}      |  85 +++--
> > >  ...or-recovery.txt => pci-error-recovery.rst} | 287 +++++++-------
> > >  .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 161 ++++----
> > >  Documentation/PCI/{pci.txt => pci.rst}        | 356 ++++++++----------
> > >  .../{pcieaer-howto.txt => pcieaer-howto.rst}  | 156 +++++---
> > >  .../{PCIEBUS-HOWTO.txt => picebus-howto.rst}  | 140 ++++---
> > >  Documentation/index.rst                       |   1 +
> > >  MAINTAINERS                                   |   4 +-
> > >  include/linux/mod_devicetable.h               |  19 +
> > >  include/linux/pci.h                           |  37 ++
> > >  17 files changed, 938 insertions(+), 710 deletions(-)
> > >  rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (96%)
> > >  create mode 100644 Documentation/PCI/endpoint/index.rst
> > >  rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
> > >  rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (83%)
> > >  rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (55%)
> > >  rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (78%)
> > >  create mode 100644 Documentation/PCI/index.rst
> > >  rename Documentation/PCI/{MSI-HOWTO.txt => msi-howto.rst} (88%)
> > >  rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (67%)
> > >  rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)
> > >  rename Documentation/PCI/{pci.txt => pci.rst} (68%)
> > >  rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (72%)
> > >  rename Documentation/PCI/{PCIEBUS-HOWTO.txt => picebus-howto.rst} (70%)
> > > 
> > > -- 
> > > 2.20.1
> > >   
> > 
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
