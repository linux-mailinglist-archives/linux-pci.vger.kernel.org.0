Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C231878E6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 05:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgCQE5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 00:57:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35034 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgCQE5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 00:57:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20so24843851edj.2;
        Mon, 16 Mar 2020 21:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9Mssj/6IzuQ2UbwiJqBfsEr29/GAc3gWyl0M/hxDuU=;
        b=HLpm8bkWcK4sc60kVlM/fecLDvKzJy5BHCY1ojSFdZkG0o/kzsxQ3teAaJTf9ytgf3
         zvR9cCe4CNeGdrzmnk8WBwZcNRVW6FEqEUTmP7zLJTtigNKWWU0R3WAR33jd5vX3aC7k
         K+j+veA1bQTd/AC5mvYXvgbJOhOmxQVEOUtje/tHz+P3V1XYxjAPgM5G60ByL5+ylL0e
         cAEVpGw3fnTxHgTsee1dBixEDKTDmsMwJeD8JtJR9vJhwKsZvLWq/iP+2vBE+doNRhs2
         zC2JTZFAz+f8xe28TwzBcrETYPY05Ahd51nO0MQDx65MuMm20OADk7FI+dTYZ+7okT8O
         Q8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9Mssj/6IzuQ2UbwiJqBfsEr29/GAc3gWyl0M/hxDuU=;
        b=HuASX5mvMxRW7I/pJrDzKRph0OJcekUgkUfnTY+xBNSiGx5/cXnX7Rb8sUXT3hrrnT
         0Ewr4oHZN+ITCh5YYa9aQ7ZbHxGwBIy4qj1BkSJjqvORhCnuXVNCB+sE7kWH2VnTDok9
         eHZRJ9yClqZh5SnqgJLT2+Yf0zGLgNGqFxclwaml6r9jK8WVZ7zzSvlj0j/AQg7Ffu3w
         CAqkjyImNU6kilG4bEBVloGAAsxs2baajSbnJvOLyCwErZf7vtjKlC+3K4/c4L4Xj1jq
         hUSnPoAbvQ1ETba6o7QiEPvN9WCY26cOidxd4JCYuDXF0y4O2+1ZJ6oO8+G7D9N39e7u
         vyrg==
X-Gm-Message-State: ANhLgQ2u063N20ZkYXfSVU5mTiBX8xX5O5zl3QddVrr4pnkd2o9iCymt
        H6jMVMD7VsZtk82aPUrarSrbuAuC2jhJhb+3I5OAJosi
X-Google-Smtp-Source: ADFU+vuvrOLJlkhXKEHhDzOZfcFDQo+gE1dCv6CmYHrIRf3LQxPlEZ7gz5GxgLY0K9/rHh5MHvXxJ5zUaAZ55L1wpmM=
X-Received: by 2002:a50:c05c:: with SMTP id u28mr3308259edd.193.1584421069721;
 Mon, 16 Mar 2020 21:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200314194745.GB12510@mail.rc.ru>
In-Reply-To: <20200314194745.GB12510@mail.rc.ru>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 16 Mar 2020 21:57:37 -0700
Message-ID: <CAEdQ38Gz+LXMNDnGvxM6t+6YcdXryLN781x=uTZvJ_huF8Gv6w@mail.gmail.com>
Subject: Re: [PATCH] alpha: fix nautilus PCI setup
To:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 14, 2020 at 12:47 PM Ivan Kokshaysky
<ink@jurassic.park.msu.ru> wrote:
>
> Example (hopefully reasonable) of the new "size_windows" flag usage.
>
> Fixes accidental breakage caused by commit f75b99d5a77d (PCI: Enforce
> bus address limits in resource allocation),

Works great. Thanks Ivan!

Tested-by: Matt Turner <mattst88@gmail.com>
