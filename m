Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4D8BEA9A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 04:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbfIZC3g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 22:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733043AbfIZC3f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Sep 2019 22:29:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FCCD222BE;
        Thu, 26 Sep 2019 02:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569464975;
        bh=gKfGul5rMc5lOK9jOOGta+8Tyf25lv4J5Sze6uJLb4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kjL4U/3R454A4GBihq/7Flb3hrZ6dLUyxf14e/UsJsxdOqZchVXFs1VBmYqVOit1D
         cB5brovsFqiTYCseK6y5fLJby/JBCFrMrF0wpZ96MqkwuuxOuqs9tnpFaGZcKkNg3v
         lKKlpSbGuKpy9pXg02rxVOM7Qv0e3oFOIOhsKMVU=
Date:   Wed, 25 Sep 2019 21:29:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-scsi@vger.kernel.org, Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v3 18/26] scsi: pm80xx: Use PCI_STD_NUM_BARS
Message-ID: <20190926022933.GB238374@google.com>
References: <20190916204158.6889-1-efremov@linux.com>
 <20190916204158.6889-19-efremov@linux.com>
 <yq1wody4eml.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1wody4eml.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 23, 2019 at 10:22:42PM -0400, Martin K. Petersen wrote:
> 
> Denis,
> 
> > Replace the magic constant (6) with define PCI_STD_NUM_BARS
> > representing the number of PCI BARs.
> 
> Applied to 5.4/scsi-fixes. Thanks!

I think this depends on a previous patch that actually adds the
PCI_STD_NUM_BARS definition.  It will probably be easier if I apply
the whole series via the PCI tree.

Bjorn
