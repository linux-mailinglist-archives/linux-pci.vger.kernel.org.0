Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1667893B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2019 12:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfG2KGY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jul 2019 06:06:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37001 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KGX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2019 06:06:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so36058650wrr.4;
        Mon, 29 Jul 2019 03:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+lJIZvSYaI3dYqcvOi7SpRuQ2vDd2GcTwOMwgzFwFeQ=;
        b=eTMwZGsZPWdmEJjs99WUJFKBDdD82YDtw9Ag8YZpY8QnKEEiRlMzSrwyGSMLn2NdeK
         isZxbTkdEE42zDjeBLSAyqcLn+gAMF/vzjAGiAfHB0+5iaWD9qZlV4jkiRgP9CgOBcVT
         ng7woj3uceqRrsyXYiwGs6Fyb3QQ3Sw2eZM5CTWDWDzAuhP4oE4Ujq4CrJMz96CoVQiC
         1ypWbzryWhwrrS9DDfLc4awqzTEaPQGt0lddDLlmr58F/gYXsyZq4Trn2MntIBoyDaam
         zrGymBktPE8QbxDlZySASFq765698cVjLEW180nOS88JAzMp1CYWQkc4Qt+MxtWbVbUu
         wr9w==
X-Gm-Message-State: APjAAAXgeIjeNH+sfayEwpn8UPIxQJEFpAO79dG4ehkDNfjcZgPnMY7t
        HrIcIyjZeQ8dIQQw4mplhXT0AET00nc=
X-Google-Smtp-Source: APXvYqwRktv2fozVreuUhBqi1B5R21SS7JUFpkXMpWHHKx1itYi/JgJWJHXGc58FiILOo4GtbsPbvA==
X-Received: by 2002:a5d:4e45:: with SMTP id r5mr10938244wrt.206.1564394781631;
        Mon, 29 Jul 2019 03:06:21 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id x18sm54245837wmi.12.2019.07.29.03.06.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 03:06:21 -0700 (PDT)
Subject: Re: [EXTERNAL][PATCH 1/5] PCI: Convert pci_resource_to_user to a weak
 function
To:     Paul Burton <paul.burton@mips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190728202213.15550-1-efremov@linux.com>
 <20190728202213.15550-2-efremov@linux.com>
 <20190728224953.kezztdozc6k24ya3@pburton-laptop>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <cd83d298-45f6-7330-0347-96025cde8959@linux.com>
Date:   Mon, 29 Jul 2019 13:06:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728224953.kezztdozc6k24ya3@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Paul,

On 29.07.2019 01:49, Paul Burton wrote:
> Hi Denis,
> 
> This is wrong - using __weak on the declaration in a header will cause
> the weak attribute to be applied to all implementations too (presuming
> the C files containing the implementations include the header). You then
> get whichever impleentation the linker chooses, which isn't necessarily
> the one you wanted.

Thank you for pointing me on that. I will prepare the v2.
