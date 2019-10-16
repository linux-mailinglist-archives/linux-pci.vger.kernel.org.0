Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A70D942A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 16:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfJPOoW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 10:44:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33727 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbfJPOoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 10:44:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so14888513pfl.0;
        Wed, 16 Oct 2019 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=0wM1+4IO1bY5BTi6K7Yji/0+jGvbIiPygIqwyuwJlfU=;
        b=tOvEAIgqFTKi5LFuzuzGZixhErKJm3yjDG6HKm30AMcV2JhEnsOdP9rJ1oVbKSrb7l
         mOGXYib8/sgyEXtNKdVfvxD0jC8gybPrFM38DsfdkMoGKA3MbcCyM9xZZcgdhrukzLv6
         4gMKstUxUeIuxYbj1WrTF+SaC6Hs6IffTeq7gHHC2jvyvh7Qkpi3Bgq/6aw8LzSBxSSg
         tlTT8fwT/bHTMnZ0hzeQAInq3oz7xhxv11AhhGUry5y7awa0eV0bDUUmb0ceyvhoiNLR
         PaGD7BtgtqH6nb/DylBbtJLjDHEPev/wI2Oh6X98Mi9GN/7aCCxXgGUhLLJ56nDXXtQO
         T/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=0wM1+4IO1bY5BTi6K7Yji/0+jGvbIiPygIqwyuwJlfU=;
        b=WJwu7YiLhA9EMHMaHr58wZpZ5zEO9VPZCEt1U8hT55BbHs6EqxZoFr6DCgomAbBx4U
         jG7NeF2cibpXONd7NWxo1wd73yF0MMZoujDRGf2peEXAzfKSiAq7NPEw+P+ydPIWPFgF
         VdDPJ89w7gTtdgL2j+4aoD41mXWSGz+yaQ2tZdGkTIsXXWlgb2/0Q4iPvXtXu+KoH5Af
         gXhxcQUs7sdkCbR6I5VFnrMqeIeHCKZ40xsKQ+cwkC5gJ6x42x3eJkl/UInw8ZVKH27F
         MRaZ++w5gaPKADTtU/FTwfRAEaAf1I2GWDtBtv2NDCOppg2WadNW+vPVksDPMsaF48V5
         1FaA==
X-Gm-Message-State: APjAAAW3nvFnY7yOmL+II8nzIYSjQQUqa8AWBVbJxq73fup47eu3coZR
        IGTDvTQTZHhIQYgcaEhRpnc=
X-Google-Smtp-Source: APXvYqy3lpffubpVvlmyh30qUtp1f0ncXogj09ETjm55Zk00R4WxRN8QY95MvMfdqWaKHhLIbWziSg==
X-Received: by 2002:a63:d0a:: with SMTP id c10mr44006817pgl.203.1571237059486;
        Wed, 16 Oct 2019 07:44:19 -0700 (PDT)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id v9sm23693755pfe.1.2019.10.16.07.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:44:18 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     'Christoph Hellwig' <hch@infradead.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "vidyas@nvidia.com" <vidyas@nvidia.com>,
        'Anvesh Salveru' <anvesh.s@samsung.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH v3] PCI: dwc: Add support to add GEN3 related equalization
 quirks
Thread-Topic: [PATCH v3] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Thread-Index: ATFlMXAyX9siOHFasDKw4/raoiQM8nluLS0yNDIwODAkNDkkZDlBNDAxJDkxJGQ1QTMwMb0Ze/7q
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Wed, 16 Oct 2019 14:44:12 +0000
Message-ID: <SL2P216MB010526CC784E2F4364B4197DAA920@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <CGME20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1@epcas5p1.samsung.com>
 <1571108362-25962-1-git-send-email-pankaj.dubey@samsung.com>
 <20191015081620.GA28204@infradead.org>
 <068001d58336$a76ed970$f64c8c50$@samsung.com>
 <20191015090547.GA7199@infradead.org>
 <000e01d5836b$ac871190$059534b0$@samsung.com>
 <20191016065234.GA6825@infradead.org>
In-Reply-To: <20191016065234.GA6825@infradead.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/16/19, 2:52 AM, 'Christoph Hellwig' wrote:
>
> On Tue, Oct 15, 2019 at 08:47:32PM +0530, Pankaj Dubey wrote:
> > OK, but do we think the current driver has only code which is being use=
d by
> > some user?
>
> That is at least the intent of how we do kernel development.=20

Agreed!

>
> > At least I can see current driver has some features which is not being =
used
> > by any current driver. =20
>
> Please send patches to remove them.

Agreed!

Mainline kernel should not include features that have not been used.
Thank you.

Best regards,
Jingoo Han
